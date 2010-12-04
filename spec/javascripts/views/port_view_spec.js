(function() {
  var Rufinol, test_data;
  Rufinol = this.Rufinol;
  test_data = Rufinol.test_data.board.digital_ports[0];
  describe("PortView", function() {
    var port, view;
    port = null;
    view = null;
    beforeEach(function() {
      setFixtures("<script id='port' type='text/html'>{{hi}}</script>");
      port = new Rufinol.models.Port(test_data);
      return (view = new Rufinol.views.PortView({
        model: port
      }));
    });
    it("should able to be instantiated", function() {
      expect(view).toBeDefined();
      return expect(view).not.toBeNull();
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
        return expect(rendered.length).toEqual(test_data.pins.length);
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
        return view.renderPin(view.model.pins[0]);
      });
      it("should create a view for the pin", function() {
        return expect(view.createPinView).toHaveBeenCalledWith(view.model.pins[0]);
      });
      return it("should render the pin and append the results to .digital-pins", function() {
        return expect(el.append).toHaveBeenCalledWith(el);
      });
    });
  });
}).call(this);
