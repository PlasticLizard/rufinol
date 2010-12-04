Rufinol = this.Rufinol
test_data = Rufinol.test_data.board.digital_ports[0]

describe "PortView", ->
  port = null
  view = null

  beforeEach ->
    setFixtures "<script id='port' type='text/html'>{{hi}}</script>"
    port = new Rufinol.models.Port(test_data)
    view = new Rufinol.views.PortView(model : port)

  it "should able to be instantiated", ->
    expect(view).toBeDefined()
    expect(view).not.toBeNull()

  describe "renderPins", ->
    rendered = []

    beforeEach ->
      spyOn(view, "renderPin").andCallFake (pin) -> rendered.push(pin)
      view.renderPins()

    it "should call render pin once for each pin", ->
      expect(rendered.length).toEqual test_data.pins.length

  describe "renderPin", ->
    el = null
    beforeEach ->
      el = { append : -> }
      pinView = { render : ->  { el : el } }

      spyOn(view, "createPinView").andReturn(pinView)
      spyOn(view,"$").andReturn(el)
      spyOn(el, "append")
      view.renderPin(view.model.pins[0])

    it "should create a view for the pin", ->
      expect(view.createPinView).toHaveBeenCalledWith(view.model.pins[0])

    it "should render the pin and append the results to .digital-pins", ->
      expect(el.append).toHaveBeenCalledWith(el)




