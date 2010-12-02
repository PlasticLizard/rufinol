module Rufirmata

  class Board
    def to_message
      {
        :board_type => board_type.dup,
        :name => name,
        :analog_pins => analog.map { |p| p.to_message},
        :digital_ports => digital_ports.map { |p| p.to_message},
        :firmata_version => firmata_version,
        :firmware => firmware
      }
    end
  end

  class Pin
    def to_message
      {
        :pin_type =>  pin_type == Rufirmata::DIGITAL ? "Digital" : "Analog",
        :pin_number => pin_number,
        :mode => mode,
        :pwm => pwm,
        :reporting => reporting,
        :value => value
      }
    end
  end

  class Port
    def to_message
      {
        :pins => pins.map { |p| p.to_message},
        :reporting => reporting,
        :port_number => port_number
      }
    end
  end

end
