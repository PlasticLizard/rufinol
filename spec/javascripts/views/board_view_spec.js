(function() {
  var Rufinol, test_data;
  Rufinol = this.Rufinol;
  test_data = Rufinol.test_data.board;
  describe("BoardView", function() {
    var board, view;
    board = null;
    view = null;
    beforeEach(function() {
      setFixtures("<script id='board' type='text/html'>{{hi}}</script>");
      board = new Rufinol.models.Board(test_data);
      return (view = new Rufinol.views.BoardView({
        model: board
      }));
    });
    it("should able to be instantiated", function() {
      expect(view).toBeDefined();
      return expect(view).not.toBeNull();
    });
    describe("renderPorts", function() {
      var rendered;
      rendered = [];
      beforeEach(function() {
        spyOn(view, "renderPort").andCallFake(function(port) {
          return rendered.push(port);
        });
        return view.renderPorts();
      });
      return it("should call render port once for each port", function() {
        return expect(rendered.length).toEqual(test_data.digital_ports.length);
      });
    });
    describe("renderPort", function() {
      var el;
      el = null;
      beforeEach(function() {
        var portView;
        el = {
          append: function() {}
        };
        portView = {
          render: function() {
            return {
              el: el
            };
          }
        };
        spyOn(view, "createPortView").andReturn(portView);
        spyOn(view, "$").andReturn(el);
        spyOn(el, "append");
        return view.renderPort(view.model.digital_ports[0]);
      });
      it("should create a view for the port", function() {
        return expect(view.createPortView).toHaveBeenCalledWith(view.model.digital_ports[0]);
      });
      return it("should render the port and append the results to .digital-ports", function() {
        return expect(el.append).toHaveBeenCalledWith(el);
      });
    });
    describe("renderPins", function() {
      var rendered;
      rendered = [];
      beforeEach(function() {
        spyOn(view, "renderPin").andCallFake(function(pin) {
          return rendered.push(pin);
        });
        return view.renderPins();
      });
      return it("should call render pin once for each pin", function() {
        return expect(rendered.length).toEqual(test_data.analog_pins.length);
      });
    });
    return describe("renderPin", function() {
      var el;
      el = null;
      beforeEach(function() {
        var pinView;
        el = {
          append: function() {}
        };
        pinView = {
          render: function() {
            return {
              el: el
            };
          }
        };
        spyOn(view, "createPinView").andReturn(pinView);
        spyOn(view, "$").andReturn(el);
        spyOn(el, "append");
        return view.renderPin(view.model.analog_pins[0]);
      });
      return it("should create a view for the pin", function() {
        return expect(view.createPinView).toHaveBeenCalledWith(view.model.analog_pins[0]);
      });
    });
  });
}).call(this);
