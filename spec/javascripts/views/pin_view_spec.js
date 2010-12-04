(function() {
  var Rufinol, test_data;
  Rufinol = this.Rufinol;
  test_data = Rufinol.test_data.board.digital_ports[0].pins[5];
  describe("PinView", function() {
    var pin, view;
    pin = null;
    view = null;
    beforeEach(function() {
      setFixtures("<script id='pin' type='text/html'>{{hi}}</script>");
      pin = new Rufinol.models.Pin(test_data);
      return (view = new Rufinol.views.PinView({
        model: pin
      }));
    });
    return it("should able to be instantiated", function() {
      expect(view).toBeDefined();
      return expect(view).not.toBeNull();
    });
  });
}).call(this);
