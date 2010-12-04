Rufinol = this.Rufinol
test_data = Rufinol.test_data.board

describe "Board", ->
  board = null

  beforeEach -> board = new Rufinol.models.Board(test_data)

  it "should able to be instantiated", ->
    expect(board).toBeDefined()
    expect(board).not.toBeNull()

  it "should initialize a digital_ports collection from provided data", ->
    expect(board.digital_ports).toBeDefined()
    expect(board.digital_ports).not.toBeNull()
    expect(board.digital_ports.length).toEqual 2

  it "should initialize an analog_pins collction from provided data", ->
    expect(board.analog_pins).toBeDefined()
    expect(board.analog_pins).not.toBeNull()
    expect(board.analog_pins.length).toEqual 6

  describe "updatePin", ->
    pin = { set : -> }

    beforeEach ->
      spyOn(board, "findPin").andReturn pin
      spyOn(pin, "set")
      board.updatePin( id : "d1" )

    it "should attempt to find the pin by its id", ->
      expect(board.findPin).toHaveBeenCalledWith "d1", undefined

    it "should set the provided pin data on the pin", ->
      expect(pin.set).toHaveBeenCalledWith { id : "d1" }

  describe "findPin", ->
    beforeEach ->
      spyOn(board.analog_pins, "get").andReturn()
      spyOn(board.digital_ports.at(0).pins, "get").andReturn()

    it "should attept to get a pin from analog pins when id starts with a", ->
      board.findPin "a0"
      expect(board.analog_pins.get).toHaveBeenCalledWith "a0"

    it "should attempt to get a pin from the specified port when id starts with d", ->
      board.findPin "d1", 0
      expect(board.digital_ports.at(0).pins.get).toHaveBeenCalledWith "d1"


