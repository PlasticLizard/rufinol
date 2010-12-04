(function() {
  var BoardView, Rufinol;
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
  BoardView = function() {
    return Rufinol.views.Base.apply(this, arguments);
  };
  __extends(BoardView, Rufinol.views.Base);
  BoardView.prototype.initialize = function(options) {
    return BoardView.__super__.initialize.call(this, options);
  };
  BoardView.prototype.templateSelector = "#board";
  BoardView.prototype.render = function() {
    BoardView.__super__.render.apply(this, arguments);
    this.renderPorts();
    this.renderPins();
    return this;
  };
  BoardView.prototype.renderPorts = function() {
    return this.model.digital_ports.each(__bind(function(port) {
      return this.renderPort(port);
    }, this));
  };
  BoardView.prototype.renderPort = function(port) {
    var portView;
    portView = this.createPortView(port);
    return this.$(".digital-ports").append(portView.render().el);
  };
  BoardView.prototype.createPortView = function(port) {
    return new Rufinol.views.PortView({
      model: port
    });
  };
  BoardView.prototype.renderPins = function() {
    return this.model.analog_pins.each(__bind(function(pin) {
      return this.renderPin(pin);
    }, this));
  };
  BoardView.prototype.renderPin = function(pin) {
    var pinView;
    pinView = this.createPinView(pin);
    return this.$(".analog-pins").append(pinView.render().el);
  };
  BoardView.prototype.createPinView = function(pin) {
    return new Rufinol.views.PinView({
      model: pin
    });
  };
  Rufinol.views.BoardView = BoardView;
}).call(this);
