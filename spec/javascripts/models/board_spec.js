(function() {
  var Rufinol, test_data;
  Rufinol = this.Rufinol;
  test_data = Rufinol.test_data.board;
  describe("Board", function() {
    var board;
    board = null;
    beforeEach(function() {
      return (board = new Rufinol.models.Board(test_data));
    });
    it("should able to be instantiated", function() {
      expect(board).toBeDefined();
      return expect(board).not.toBeNull();
    });
    it("should initialize a digital_ports collection from provided data", function() {
      expect(board.digital_ports).toBeDefined();
      expect(board.digital_ports).not.toBeNull();
      return expect(board.digital_ports.length).toEqual(2);
    });
    it("should initialize an analog_pins collction from provided data", function() {
      expect(board.analog_pins).toBeDefined();
      expect(board.analog_pins).not.toBeNull();
      return expect(board.analog_pins.length).toEqual(6);
    });
    describe("updatePin", function() {
      var pin;
      pin = {
        set: function() {}
      };
      beforeEach(function() {
        spyOn(board, "findPin").andReturn(pin);
        spyOn(pin, "set");
        return board.updatePin({
          id: "d1"
        });
      });
      it("should attempt to find the pin by its id", function() {
        return expect(board.findPin).toHaveBeenCalledWith("d1", undefined);
      });
      return it("should set the provided pin data on the pin", function() {
        return expect(pin.set).toHaveBeenCalledWith({
          id: "d1"
        });
      });
    });
    return describe("findPin", function() {
      beforeEach(function() {
        spyOn(board.analog_pins, "get").andReturn();
        return spyOn(board.digital_ports.at(0).pins, "get").andReturn();
      });
      it("should attept to get a pin from analog pins when id starts with a", function() {
        board.findPin("a0");
        return expect(board.analog_pins.get).toHaveBeenCalledWith("a0");
      });
      return it("should attempt to get a pin from the specified port when id starts with d", function() {
        board.findPin("d1", 0);
        return expect(board.digital_ports.at(0).pins.get).toHaveBeenCalledWith("d1");
      });
    });
  });
}).call(this);
