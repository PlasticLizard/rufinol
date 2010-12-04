Rufinol = this.Rufinol
test_data = Rufinol.test_data.board.digital_ports[0].pins[5]

describe "PinView", ->
  pin = null
  view = null

  beforeEach ->
    setFixtures "<script id='pin' type='text/html'>{{hi}}</script>"
    pin = new Rufinol.models.Pin(test_data)
    view = new Rufinol.views.PinView(model : pin)

  it "should able to be instantiated", ->
    expect(view).toBeDefined()
    expect(view).not.toBeNull()



