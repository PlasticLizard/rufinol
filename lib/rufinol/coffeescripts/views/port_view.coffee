Rufinol = this.Rufinol ||= {}
Rufinol.views ||= {}

class PortView extends Rufinol.views.Base
  templateSelector : "#port"

  render : ->
    super
    this.renderPins()
    this

  renderPins : ->
    this.model.pins.each (pin) =>
      this.renderPin(pin)

  renderPin : (pin) ->
    pinView = this.createPinView(pin)
    this.$(".digital-pins").append( pinView.render().el )

  createPinView : (pin) -> new Rufinol.views.PinView( model : pin)

Rufinol.views.PortView = PortView