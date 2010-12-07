Rufinol = this.Rufinol
test_data = Rufinol.test_data.board

describe "Application", ->
  application = null
  beforeEach ->
    setFixtures "<p id='board'>{{hi}}</p><p id='port'>{{hi}}</p><p id='pin'>{{hi}}</p>"
    spyOn(_, "bindAll").andReturn()
    application = new Rufinol.views.Application( boardData : test_data.board, webSocketUri : "ws" )


  describe "initialize", ->
    it "should bind socket events", ->
      expect(_.bindAll).toHaveBeenCalledWith application, "onSocketMessage", "onSocketOpen", "onSocketClose"

    it "should set the board model from provided data", ->
      expect(application.board).toBeDefined()
      expect(application.board).not.toBeNull()

    it "should set the board view from the initialized model", ->
      expect(application.boardView).not.toBeNull()
      expect(application.boardView.model).toEqual application.board

    it "should set the 'el' property to the document body", ->
      expect($(application.el)).toBe "body"

    it "should set the webSocketUri property from options", ->
      expect(application.webSocketUri).toEqual "ws"

  describe "start", ->
    beforeEach ->
      spyOn(application, "render").andReturn()
      spyOn(application, "initializeWebSockets").andReturn()
      application.start()

    it "should call render", ->
      expect(application.render).toHaveBeenCalled()

    it "should call initializeWebSockets", ->
      expect(application.initializeWebSockets).toHaveBeenCalled()

  describe "render", ->
    boardView = { render : -> { el : "hi" } }

    beforeEach ->
      application.boardView = boardView
      spyOn(application.el, "append")
      application.render()

    it "should append the rendered boardView to its element", ->
      expect(application.el.append).toHaveBeenCalledWith "hi"

  describe "initializeWebSockets", ->
    beforeEach ->
      application.socket = {}
      application.initializeWebSockets()

    it "should subscribe to socket events", ->
      expect(application.socket.onmessage).toEqual application.onSocketMessage
      expect(application.socket.onclose).toEqual application.onSocketClose
      expect(application.socket.onopen).toEqual application.onSocketOpen

  describe "sending commands to the server", ->
    beforeEach ->
      application.socket = { send : -> }
      spyOn(application.socket,"send").andReturn()

    describe "sendPinMode", ->
      pin = { id : "123", get : -> 100 }
      beforeEach ->
        spyOn(pin, "get").andReturn "100"
        application.sendPinMode(pin)

      it "should get the pin mode from the pin", ->
        expect(pin.get).toHaveBeenCalledWith("mode")

      it "should send the setPinMode command", ->
        expectedMessage = JSON.stringify { command : "setPinMode", pin : pin.id, mode : "100" }
        expect(application.socket.send).toHaveBeenCalledWith expectedMessage

    describe "sendPinValue", ->
      pin = { id : "123", get : -> 1.0 }
      beforeEach ->
        spyOn(pin, "get").andReturn ("1.0")
        application.sendPinValue(pin)

      it "should get the pin value from the pin", ->
        expect(pin.get).toHaveBeenCalledWith("value")

      it "should send the setPinValue command", ->
        expectedMessage = JSON.stringify { command : "setPinValue", pin : pin.id, value : "1.0" }
        expect(application.socket.send).toHaveBeenCalledWith expectedMessage

  describe "onSocketMessage", ->
    beforeEach ->
      spyOn(application.board, "updatePin")
      message =  { data : JSON.stringify(hi:"there") }
      application.onSocketMessage( message )

    it "should call @board.updatePin with parsed pin data", ->
      expect(application.board.updatePin).toHaveBeenCalledWith { hi : "there" }




