(function() {
  var Pin, PinCollection, Rufinol;
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
  Pin = function() {
    return Backbone.Model.apply(this, arguments);
  };
  __extends(Pin, Backbone.Model);
  Pin.prototype.setPinMode = function(newMode) {
    this.set({
      mode: newMode
    });
    return Rufinol.app.sendPinMode(this);
  };
  Pin.prototype.setPinValue = function(newValue) {
    var oldValue;
    oldValue = this.get("value");
    if (oldValue.toString() !== newValue.toString()) {
      this.set({
        value: newValue
      });
      return Rufinol.app.sendPinValue(this);
    }
  };
  PinCollection = function() {
    return Backbone.Collection.apply(this, arguments);
  };
  __extends(PinCollection, Backbone.Collection);
  PinCollection.prototype.model = Pin;
  this.Rufinol.models.Pin = Pin;
  this.Rufinol.models.PinCollection = PinCollection;
}).call(this);
