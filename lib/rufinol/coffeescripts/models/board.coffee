Rufinol = this.Rufinol ||= { models : {} }

class Board extends Backbone.Model
  initialize : (data,options) ->
    this.digital_ports = new Rufinol.models.PortCollection(this.get("digital_ports"))
    this.analog_pins = new Rufinol.models.PinCollection(this.get("analog_pins"))

  updatePin : (pinData) ->
    pin = this.findPin(pinData.id, pinData.port_number)
    pin.set(pinData) if pin

  findPin : (pinId, portNumber) ->
    pins = if pinId[0] == "a" then this.analog_pins else this.digital_ports.at(portNumber).pins
    pins.get(pinId)


this.Rufinol.models.Board = Board