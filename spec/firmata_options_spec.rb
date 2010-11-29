require "spec_helper"

describe Rufinol::FirmataOptions do
  subject { Rufinol::FirmataOptions}
  describe "parse!" do
    describe "with no args" do
      before(:each){ subject.parse!}
      it "should default to 57600 baud rate" do
        subject.baud_rate.should == 57600
      end

      it "should default to a nil serial port" do
        subject.serial_port.should be_nil
      end
    end
  end
end
