require 'rubygems'
require 'thin'
require 'eventmachine'
require 'em-websocket'
require 'rufirmata'
require 'json'

base_dir = File.dirname(__FILE__)
[
 'version',
 'firmata_options',
 'application'
].each {|req| require File.join(base_dir,'rufinol',req)}

module Rufinol
  class << self
    attr_reader :channel, :firmata

    def root
      ::File.expand_path(File.join(File.dirname(__FILE__),'..'))
    end

    def run
      argv = Rufinol::FirmataOptions.parse!(ARGV)

      rackup_file = File.join(root,'config.ru')

      argv << ["-R", rackup_file] unless ARGV.include?("-R")
      argv << ["-p", "3000"] unless ARGV.include?("-p")
      #argv << ["-e", "production"] unless ARGV.include?("-e")



      EM.run do
        initialize_rufirmata
        initialize_web_sockets(argv)
        initialize_web_server(argv)

      end

      shutdown_firmata
      end


    def configure!
    end

    private

    def iterate_rufirmata
      @firmata.iterate
      EM.next_tick {  EM.defer {  iterate_rufirmata } }
    end

    def initialize_rufirmata
      assert_serial_port_specified!
      @firmata = Arduino.new Rufinol::FirmataOptions.serial_port,
      :baud_rate=>Rufinol::FirmataOptions.baud_rate, :auto_start=>false
      @firmata.digital[5].mode = Rufirmata::INPUT

      @firmata.set_observer(:pattern=>/after/) do |board, change_type, args|
        if self.channel
          begin
            pin = args.delete(:pin)
            message = pin_status_message(pin)
            self.channel.push message
          rescue Exception => ex
            puts ex.message
            puts ex.backtrace
          end
        end

        iterate_rufirmata
      end

    end

    def shutdown_firmata
      @firmata.close
    end

    def pin_status_message(pin)
      pin_type = pin.pin_type == Rufirmata::DIGITAL ? "Digital" : "Analog"
      JSON.dump :pin_type=>pin_type, :pin_number=>pin.pin_number,
                :pin_mode=>pin.mode, :value=>pin.value, :reporting=>pin.reporting
    end

    def initialize_web_server(argv)
      Thin::Runner.new(argv.flatten).run!
    end

    def initialize_web_sockets(argv)
      @channel = EM::Channel.new
      EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 3001) do |ws|

        ws.onopen do
          sid = @channel.subscribe { |msg| ws.send msg }

          ws.onmessage { |msg| @channel.push msg }

          ws.onclose { @channel.unsubscribe(sid) }
        end

      end
    end

    def assert_serial_port_specified!
      raise "A serial port was not specified. Please specify the serial port identifier of your device using --sp, for example rufinol start --sp /dev/ttyUSB0" unless Rufinol::FirmataOptions.serial_port
    end

  end
end
