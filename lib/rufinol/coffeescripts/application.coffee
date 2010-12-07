Rufinol = this.Rufinol ||= {}
Rufinol.views ||= {}

class Application extends Backbone.View
  initialize : (options) ->
    _.bindAll this, "onSocketMessage", "onSocketOpen", "onSocketClose"
    boardData = options.boardData if options
    @board = new Rufinol.models.Board(boardData)
    @boardView = new Rufinol.views.BoardView(model : @board)
    @el = $("body")
    @webSocketUri = options.webSocketUri
    this

  start : ->
    this.render()
    this.initializeWebSockets()
    this

  render : ->
    this.el.append( @boardView.render().el )
    this

  initializeWebSockets : ->
    @socket ||= new WebSocket(@webSocketUri)
    @socket.onmessage = this.onSocketMessage
    @socket.onclose = this.onSocketClose
    @socket.onopen = this.onSocketOpen

  sendPinMode : (pin) ->
    command = { command : "setPinMode", pin : pin.id, mode : pin.get("mode") }
    @socket.send JSON.stringify( command )

  sendPinValue : (pin) ->
    command = command : "setPinValue", pin : pin.id, value : pin.get("value")
    @socket.send JSON.stringify ( command )

  onSocketMessage : (message) ->
    pinData = JSON.parse(message.data)
    @board.updatePin(pinData)

  onSocketClose : -> console.log "Rufinol has closed its connection with your device server"

  onSocketOpen : -> console.log "Rufinol is now connected to your device server"



Rufinol.views.Application = Application