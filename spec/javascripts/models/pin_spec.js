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
    return it("should able to be instantiated", function() {
      expect(pin).toBeDefined();
      return expect(pin).not.toBeNull();
    });
  });
}).call(this);
