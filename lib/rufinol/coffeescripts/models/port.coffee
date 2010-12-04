Rufinol = this.Rufinol ||= { models : {} }

class Port extends Backbone.Model
  initialize : (data, options) ->
    this.pins = new Rufinol.models.PinCollection(this.get("pins"))

class PortCollection extends Backbone.Collection
  model : Port

this.Rufinol.models.Port = Port
this.Rufinol.models.PortCollection = PortCollection