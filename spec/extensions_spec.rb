require "spec_helper"


describe Rufirmata::Board do
  before(:each) {
    @board = Arduino.new("sp", :auto_start=>false, :defer_init=>true)
  }
  describe "#to_message" do
    before(:each) { @message = @board.to_message}

    it "should include basic properties" do
      @message[:board_type].should == @board.board_type
      @message[:name].should == @board.name
      @message[:firmata_version].should == @board.firmata_version
      @message[:firmware].should == @board.firmware
    end

    it "should map analog pins to an analog_pins array" do
      @message[:analog_pins].each_with_index do |pin, index|
        pin.should == @board.analog[index].to_message
      end
    end

    it "should map digital ports to the digital_ports array" do
      @message[:digital_ports].each_with_index do |port,index|
        port.should == @board.digital_ports[index].to_message
      end
    end

  end
end

describe Rufirmata::Pin do
  before(:each) {
    @board = Arduino.new("sp", :auto_start=>false, :defer_init=>true)
    @pin = @board.analog[0]
    @pin.value = 1.15
  }
  describe "#to_message" do
    before(:each) {  @message = @pin.to_message }

    it "should map pin type to a string representation" do
      @message[:pin_type].should == "Analog"
    end

    it "should map basic properties" do
      @message[:pin_number].should == @pin.pin_number
      @message[:mode].should == @pin.mode
      @message[:pwm].should == @pin.pwm
      @message[:reporting].should == @pin.reporting
      @message[:value].should == 1.15
    end

  end
end

describe Rufirmata::Port do
  before(:each) {
    @board = Arduino.new("sp", :auto_start=>false, :defer_init=>true)
    @port = @board.digital_ports[0]
    @port.reporting = true
  }
  describe "#to_message" do
    before(:each){ @message = @port.to_message }

    it "should map basic properties" do
      @message[:port_number].should == @port.port_number
      @message[:reporting].should == true
    end

    it "should map digital pins" do
      @message[:pins].each_with_index do |pin,index|
        pin.should == @port.pins[index].to_message
      end
    end
  end
end



