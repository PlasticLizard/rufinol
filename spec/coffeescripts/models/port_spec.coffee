Rufinol = this.Rufinol
test_data = Rufinol.test_data.board.digital_ports[0]

describe "Port", ->
  port = null

  beforeEach -> port = new Rufinol.models.Port(test_data)

  it "should able to be instantiated", ->
    expect(port).toBeDefined()
    expect(port).not.toBeNull()

  it "should initialize a pins collection from provided data", ->
    expect(port.pins).toBeDefined()
    expect(port.pins).not.toBeNull()
    expect(port.pins.length).toEqual 8


