Rufinol = this.Rufinol
test_data = Rufinol.test_data.board.digital_ports[0].pins[5]

describe "PinView", ->
  pin = null
  view = null
  select = { val : -> }


  beforeEach ->
    setFixtures "<script id='pin' type='text/html'>{{hi}}</script>"
    pin = new Rufinol.models.Pin(test_data)
    view = new Rufinol.views.PinView(model : pin)

  it "should able to be instantiated", ->
    expect(view).toBeDefined()
    expect(view).not.toBeNull()

  describe "selectPinMode", ->
    beforeEach ->
      spyOn(view,"$").andReturn(select)
      spyOn(select, "val")
      view.selectPinMode()

    it "should set the current value of the pin mode on the pin mode selct", ->
      expect(view.$).toHaveBeenCalledWith ".pin-mode"
      expect(select.val).toHaveBeenCalledWith test_data.mode

  describe "pinModeChanged", ->
    beforeEach ->
      spyOn(view,"pinModeSelect").andReturn select
      spyOn(select, "val").andReturn(100)
      spyOn(view.model, "setPinMode")
      view.pinModeChanged()

    it "should set the new value on the model", ->
      expect(view.model.setPinMode).toHaveBeenCalledWith 100

  describe "pinValueChanged", ->
    beforeEach ->
      spyOn(view, "pinValueEditor").andReturn select
      spyOn(select, "val").andReturn("aloha")
      spyOn(view.model, "setPinValue")
      view.pinValueChanged()

    it "should set the new pin value on the model", ->
      expect(view.model.setPinValue).toHaveBeenCalledWith "aloha"

  describe "renderPinValue", ->
    describe "when the mode is 0 (INPUT)", ->
      beforeEach ->
        spyOn(view.model, "get").andReturn "0"
        spyOn(view, "renderInputPinValue")
        view.renderPinValue()
      it "should render an input UI", ->
        expect(view.renderInputPinValue).toHaveBeenCalled()

    describe "when the mode is not -1 (UNAVAILABLE, therefore OUTPUT)", ->
      beforeEach ->
        spyOn(view.model, "get").andReturn "1"
        spyOn(view, "renderOutputPinValue")
        view.renderPinValue()
      it "should render an output UI", ->
        expect(view.renderOutputPinValue).toHaveBeenCalled()

  describe "renderOutputPinValue", ->
    it "should do the right thing (i.e. I will hopefully test this later)", ->
      expect(true).toEqual(true)




