(function() {
  var Rufinol, test_data;
  Rufinol = this.Rufinol;
  test_data = Rufinol.test_data.board.digital_ports[0].pins[5];
  describe("Pin", function() {
    var pin;
    pin = null;
    beforeEach(function() {
      return (pin = new Rufinol.models.Pin(test_data));
    });
    it("should able to be instantiated", function() {
      expect(pin).toBeDefined();
      return expect(pin).not.toBeNull();
    });
    describe("setPinMode", function() {
      beforeEach(function() {
        Rufinol.app = {
          sendPinMode: function() {}
        };
        spyOn(Rufinol.app, "sendPinMode");
        return pin.setPinMode("hi");
      });
      it("should set the new value of the pin mode", function() {
        return expect(pin.get("mode")).toEqual("hi");
      });
      return it("should publish the change to the app", function() {
        return expect(Rufinol.app.sendPinMode).toHaveBeenCalledWith(pin);
      });
    });
    return describe("setPinValue", function() {
      beforeEach(function() {
        Rufinol.app = {
          sendPinValue: function() {}
        };
        spyOn(Rufinol.app, "sendPinValue");
        return pin.setPinValue("hi");
      });
      it("should set the new value of the pin", function() {
        return expect(pin.get("value")).toEqual("hi");
      });
      return it("should publish the change to the app", function() {
        return expect(Rufinol.app.sendPinValue).toHaveBeenCalledWith(pin);
      });
    });
  });
}).call(this);
