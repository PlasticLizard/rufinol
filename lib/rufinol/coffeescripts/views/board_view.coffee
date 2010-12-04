Rufinol = this.Rufinol ||= {}
Rufinol.views ||= {}

class BoardView extends Rufinol.views.Base
  initialize : (options) ->
    super(options)

  templateSelector : "#board"

  render : ->
    super
    this.renderPorts()
    this.renderPins()
    this

  renderPorts : ->
    this.model.digital_ports.each (port) =>
      this.renderPort(port)

  renderPort : (port) ->
    portView = this.createPortView(port)
    this.$(".digital-ports").append( portView.render().el )

  createPortView : (port) -> new Rufinol.views.PortView( model : port )

  renderPins : ->
    this.model.analog_pins.each (pin) =>
      this.renderPin(pin)

  renderPin : (pin) ->
    pinView = this.createPinView(pin)
    this.$(".analog-pins").append( pinView.render().el )

  createPinView : (pin) -> new Rufinol.views.PinView( model : pin)


Rufinol.views.BoardView = BoardView