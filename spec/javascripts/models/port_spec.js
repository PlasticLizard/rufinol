(function() {
  var Rufinol, test_data;
  Rufinol = this.Rufinol;
  test_data = Rufinol.test_data.board.digital_ports[0];
  describe("Port", function() {
    var port;
    port = null;
    beforeEach(function() {
      return (port = new Rufinol.models.Port(test_data));
    });
    it("should able to be instantiated", function() {
      expect(port).toBeDefined();
      return expect(port).not.toBeNull();
    });
    return it("should initialize a pins collection from provided data", function() {
      expect(port.pins).toBeDefined();
      expect(port.pins).not.toBeNull();
      return expect(port.pins.length).toEqual(8);
    });
  });
}).call(this);
