require "optparse"

module Rufinol
  class FirmataOptions
    class << self
      attr_accessor :baud_rate, :serial_port

      def parse!(args=[])
        self.baud_rate = 57600

        #Allow the serial port to be specified without a switch
        if (sp = args.select{ |arg|arg=~/.*\/tty/ }.pop)
          args.delete(sp)
          self.serial_port = sp
        end

        opts = OptionParser.new do |opts|
          opts.on "--baud BAUD",
          "The BAUD rate of your firmata devices serial connection" do |baud|
            self.baud_rate = baud.to_i
          end

          opts.on "--device", "--sp", "--serial SP", "The device identifier of the serial port your firmata device is connected to, for example /dev/ttyUSB0" do |sp|
            self.serial_port = sp
          end
        end
        opts.parse!(args)
      end

    end
  end
end

