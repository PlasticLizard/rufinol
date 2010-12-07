Rufinol = this.Rufinol ||= {}
Rufinol.views ||= {}

class PinView extends Rufinol.views.Base
  initialize : (options) ->
    super(options)
    _.bindAll this, 'render'
    this.model.bind "change", => this.render()# if this.model.get("mode").toString() == "0"

  events :
    "change .pin-mode" : "pinModeChanged"
    "change .pin-value-editor" : "pinValueChanged"

  templateSelector : "#pin"
  tagName : "tr"

  render : ->
    return if @sliding #prevent feedback from allowing change
    super
    this.selectPinMode()
    this.renderPinValue()
    this

  pinModeSelect : -> this.$(".pin-mode")
  pinValueEditor : -> this.$(".pin-value-editor")
  pinValueContainer : -> this.$(".pin-value")
  pinEditorContainer : -> this.$(".pin-editor-container")

  selectPinMode : ->
    this.pinModeSelect().val(this.model.get("mode"))

  pinModeChanged : ->
    mode = this.pinModeSelect().val()
    console.debug "Setting pin mode to #{mode}"
    this.model.setPinMode( mode )

  pinValueChanged : ->
    value = this.pinValueEditor().val()
    console.debug "Setting pin value to #{value}"
    this.model.setPinValue( value )

  renderPinValue : ->
    mode = this.model.get("mode").toString()
    if mode is "0"
      this.renderInputPinValue()
    else if mode isnt "-1"
      this.renderOutputPinValue()

  renderOutputPinValue : ->
    this.pinEditorContainer().css("width", "300px")
    this.pinEditorContainer().css("margin", "5px")
    this.pinEditorContainer().slider(
      orientation: "horizontal"
      range: "min"
      max: 100
      value: 0
      slide: =>
        this.updatePinValue( this.pinEditorContainer().slider("value") / 100.0 )
        @sliding = true
      change: =>
        this.updatePinValue( this.pinEditorContainer().slider("value") / 100.0 )
        @sliding = false
    )
    this.pinEditorContainer().slider( "value", 100 * this.model.get("value") )
    @ready = true

  updatePinValue : (newValue) ->
    value = newValue.toString()
    return if value == this.model.get("value")
    this.model.setPinValue( value ) if @ready

  renderInputPinValue : ->






Rufinol.views.PinView = PinView
