(function() {
  var Rufinol, test_data;
  Rufinol = this.Rufinol;
  test_data = Rufinol.test_data.board.digital_ports[0].pins[5];
  describe("PinView", function() {
    var pin, select, view;
    pin = null;
    view = null;
    select = {
      val: function() {}
    };
    beforeEach(function() {
      setFixtures("<script id='pin' type='text/html'>{{hi}}</script>");
      pin = new Rufinol.models.Pin(test_data);
      return (view = new Rufinol.views.PinView({
        model: pin
      }));
    });
    it("should able to be instantiated", function() {
      expect(view).toBeDefined();
      return expect(view).not.toBeNull();
    });
    describe("selectPinMode", function() {
      beforeEach(function() {
        spyOn(view, "$").andReturn(select);
        spyOn(select, "val");
        return view.selectPinMode();
      });
      return it("should set the current value of the pin mode on the pin mode selct", function() {
        expect(view.$).toHaveBeenCalledWith(".pin-mode");
        return expect(select.val).toHaveBeenCalledWith(test_data.mode);
      });
    });
    describe("pinModeChanged", function() {
      beforeEach(function() {
        spyOn(view, "pinModeSelect").andReturn(select);
        spyOn(select, "val").andReturn(100);
        spyOn(view.model, "setPinMode");
        return view.pinModeChanged();
      });
      return it("should set the new value on the model", function() {
        return expect(view.model.setPinMode).toHaveBeenCalledWith(100);
      });
    });
    describe("pinValueChanged", function() {
      beforeEach(function() {
        spyOn(view, "pinValueEditor").andReturn(select);
        spyOn(select, "val").andReturn("aloha");
        spyOn(view.model, "setPinValue");
        return view.pinValueChanged();
      });
      return it("should set the new pin value on the model", function() {
        return expect(view.model.setPinValue).toHaveBeenCalledWith("aloha");
      });
    });
    describe("renderPinValue", function() {
      describe("when the mode is 0 (INPUT)", function() {
        beforeEach(function() {
          spyOn(view.model, "get").andReturn("0");
          spyOn(view, "renderInputPinValue");
          return view.renderPinValue();
        });
        return it("should render an input UI", function() {
          return expect(view.renderInputPinValue).toHaveBeenCalled();
        });
      });
      return describe("when the mode is not -1 (UNAVAILABLE, therefore OUTPUT)", function() {
        beforeEach(function() {
          spyOn(view.model, "get").andReturn("1");
          spyOn(view, "renderOutputPinValue");
          return view.renderPinValue();
        });
        return it("should render an output UI", function() {
          return expect(view.renderOutputPinValue).toHaveBeenCalled();
        });
      });
    });
    return describe("renderOutputPinValue", function() {
      return it("should do the right thing (i.e. I will hopefully test this later)", function() {
        return expect(true).toEqual(true);
      });
    });
  });
}).call(this);
