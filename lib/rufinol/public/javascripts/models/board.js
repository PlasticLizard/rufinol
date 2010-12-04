(function() {
  var Board, Rufinol;
  var __extends = function(child, parent) {
    var ctor = function(){};
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.prototype.constructor = child;
    if (typeof parent.extended === "function") parent.extended(child);
    child.__super__ = parent.prototype;
  };
  Rufinol = this.Rufinol || (this.Rufinol = {
    models: {}
  });
  Board = function() {
    return Backbone.Model.apply(this, arguments);
  };
  __extends(Board, Backbone.Model);
  Board.prototype.initialize = function(data, options) {
    this.digital_ports = new Rufinol.models.PortCollection(this.get("digital_ports"));
    return (this.analog_pins = new Rufinol.models.PinCollection(this.get("analog_pins")));
  };
  Board.prototype.updatePin = function(pinData) {
    var pin;
    pin = this.findPin(pinData.id, pinData.port_number);
    if (pin) {
      return pin.set(pinData);
    }
  };
  Board.prototype.findPin = function(pinId, portNumber) {
    var pins;
    pins = pinId[0] === "a" ? this.analog_pins : this.digital_ports.at(portNumber).pins;
    return pins.get(pinId);
  };
  this.Rufinol.models.Board = Board;
}).call(this);
