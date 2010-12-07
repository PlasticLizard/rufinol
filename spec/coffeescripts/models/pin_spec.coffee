Rufinol = this.Rufinol
test_data = Rufinol.test_data.board.digital_ports[0].pins[5]

describe "Pin", ->
  pin = null

  beforeEach -> pin = new Rufinol.models.Pin(test_data)

  it "should able to be instantiated", ->
    expect(pin).toBeDefined()
    expect(pin).not.toBeNull()

  describe "setPinMode", ->
    beforeEach ->
      Rufinol.app = { sendPinMode : -> }
      spyOn(Rufinol.app, "sendPinMode")
      pin.setPinMode "hi"

    it "should set the new value of the pin mode", ->
      expect(pin.get("mode")).toEqual "hi"

    it "should publish the change to the app", ->
      expect(Rufinol.app.sendPinMode).toHaveBeenCalledWith pin

  describe "setPinValue", ->
    beforeEach ->
      Rufinol.app = { sendPinValue : -> }
      spyOn( Rufinol.app, "sendPinValue" )
      pin.setPinValue "hi"

    it "should set the new value of the pin", ->
      expect(pin.get("value")).toEqual "hi"

    it "should publish the change to the app", ->
      expect( Rufinol.app.sendPinValue).toHaveBeenCalledWith pin

