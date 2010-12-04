Rufinol = this.Rufinol ||= { models : {} }

class Pin extends Backbone.Model

class PinCollection extends Backbone.Collection
  model :Pin

this.Rufinol.models.Pin = Pin
this.Rufinol.models.PinCollection = PinCollection