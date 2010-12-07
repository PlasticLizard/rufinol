Rufinol = this.Rufinol ||= { models : {} }

class Pin extends Backbone.Model
  setPinMode : (newMode) ->
    this.set( mode : newMode )
    Rufinol.app.sendPinMode(this)

  setPinValue : (newValue) ->
    oldValue = this.get("value")
    if (oldValue.toString() != newValue.toString())
      this.set( value : newValue )
      Rufinol.app.sendPinValue(this)

class PinCollection extends Backbone.Collection
  model :Pin

this.Rufinol.models.Pin = Pin
this.Rufinol.models.PinCollection = PinCollection