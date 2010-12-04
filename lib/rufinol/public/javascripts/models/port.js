(function() {
  var Port, PortCollection, Rufinol;
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
  Port = function() {
    return Backbone.Model.apply(this, arguments);
  };
  __extends(Port, Backbone.Model);
  Port.prototype.initialize = function(data, options) {
    return (this.pins = new Rufinol.models.PinCollection(this.get("pins")));
  };
  PortCollection = function() {
    return Backbone.Collection.apply(this, arguments);
  };
  __extends(PortCollection, Backbone.Collection);
  PortCollection.prototype.model = Port;
  this.Rufinol.models.Port = Port;
  this.Rufinol.models.PortCollection = PortCollection;
}).call(this);
