Rufinol = this.Rufinol
test_data = Rufinol.test_data.board

describe "BoardView", ->
  board = null
  view = null

  beforeEach ->
    setFixtures "<script id='board' type='text/html'>{{hi}}</script>"
    board = new Rufinol.models.Board(test_data)
    view = new Rufinol.views.BoardView(model : board)


  it "should able to be instantiated", ->
    expect(view).toBeDefined()
    expect(view).not.toBeNull()

  describe "renderPorts", ->
    rendered = []

    beforeEach ->
      spyOn(view, "renderPort").andCallFake (port) -> rendered.push(port)
      view.renderPorts()

    it "should call render port once for each port", ->
      expect(rendered.length).toEqual test_data.digital_ports.length

  describe "renderPort", ->
    el = null
    beforeEach ->
      el = { append : -> }
      portView = { render : ->  { el : el } }

      spyOn(view, "createPortView").andReturn(portView)
      spyOn(view,"$").andReturn(el)
      spyOn(el, "append")
      view.renderPort(view.model.digital_ports[0])

    it "should create a view for the port", ->
      expect(view.createPortView).toHaveBeenCalledWith(view.model.digital_ports[0])

    it "should render the port and append the results to .digital-ports", ->
      expect(el.append).toHaveBeenCalledWith(el)

  describe "renderPins", ->
    rendered = []

    beforeEach ->
      spyOn(view, "renderPin").andCallFake (pin) -> rendered.push(pin)
      view.renderPins()

    it "should call render pin once for each pin", ->
      expect(rendered.length).toEqual test_data.analog_pins.length

  describe "renderPin", ->
    el = null
    beforeEach ->
      el = { append : -> }
      pinView = { render : ->  { el : el } }

      spyOn(view, "createPinView").andReturn(pinView)
      spyOn(view,"$").andReturn(el)
      spyOn(el, "append")
      view.renderPin(view.model.analog_pins[0])

    it "should create a view for the pin", ->
      expect(view.createPinView).toHaveBeenCalledWith(view.model.analog_pins[0])

