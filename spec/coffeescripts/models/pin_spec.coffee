Rufinol = this.Rufinol
test_data = Rufinol.test_data.board.digital_ports[0].pins[5]

describe "Pin", ->
  pin = null

  beforeEach -> pin = new Rufinol.models.Pin(test_data)

  it "should able to be instantiated", ->
    expect(pin).toBeDefined()
    expect(pin).not.toBeNull()
