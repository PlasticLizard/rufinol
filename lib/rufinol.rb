require 'rubygems'
require 'thin'
require 'eventmachine'
require 'em-websocket'
require 'rufirmata'
require 'json'

base_dir = File.dirname(__FILE__)
[
 'version',
 'extensions',
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
            self.channel.push JSON.dump(pin.to_message)
          rescue Exception => ex
            puts ex.message
            puts ex.backtrace
          end
        end
      end
      iterate_rufirmata
    end

    def shutdown_firmata
      @firmata.close
    end

    def initialize_web_server(argv)
      Thin::Runner.new(argv.flatten).run!
    end

    def initialize_web_sockets(argv)
      @channel = EM::Channel.new
      EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 3001) do |ws|

        ws.onopen do
          sid = @channel.subscribe { |msg| ws.send msg }

          ws.onmessage { |msg| handleCommand(msg) }

          ws.onclose { @channel.unsubscribe(sid) }
        end

      end
    end

    def handleCommand(message)
      command = JSON.parse(message)
      puts command.inspect
      pin_id = command["pin"]
      pin_type = pin_id[0..0]
      pin_number = pin_id[1..-1].to_i
      pin = pin_type == "a" ? @firmata.analog[pin_number] : @firmata.digital[pin_number]

      case command["command"]
      when "setPinMode" then pin.mode = command["mode"].to_i
      when "setPinValue" then pin.write command["value"].to_f
      end
    end

    def assert_serial_port_specified!
      raise "A serial port was not specified. Please specify the serial port identifier of your device using --sp, for example rufinol start --sp /dev/ttyUSB0" unless Rufinol::FirmataOptions.serial_port
    end

  end
end
