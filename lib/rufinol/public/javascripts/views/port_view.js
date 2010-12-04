(function() {
  var PortView, Rufinol;
  var __bind = function(func, context) {
    return function(){ return func.apply(context, arguments); };
  }, __extends = function(child, parent) {
    var ctor = function(){};
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.prototype.constructor = child;
    if (typeof parent.extended === "function") parent.extended(child);
    child.__super__ = parent.prototype;
  };
  Rufinol = this.Rufinol || (this.Rufinol = {});
  Rufinol.views || (Rufinol.views = {});
  PortView = function() {
    return Rufinol.views.Base.apply(this, arguments);
  };
  __extends(PortView, Rufinol.views.Base);
  PortView.prototype.templateSelector = "#port";
  PortView.prototype.render = function() {
    PortView.__super__.render.apply(this, arguments);
    this.renderPins();
    return this;
  };
  PortView.prototype.renderPins = function() {
    return this.model.pins.each(__bind(function(pin) {
      return this.renderPin(pin);
    }, this));
  };
  PortView.prototype.renderPin = function(pin) {
    var pinView;
    pinView = this.createPinView(pin);
    return this.$(".digital-pins").append(pinView.render().el);
  };
  PortView.prototype.createPinView = function(pin) {
    return new Rufinol.views.PinView({
      model: pin
    });
  };
  Rufinol.views.PortView = PortView;
}).call(this);
