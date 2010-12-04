Rufinol = this.Rufinol ||= {}
Rufinol.views ||= {}

class PinView extends Rufinol.views.Base
  initialize : (options) ->
    super(options)
    _.bindAll this, 'render'
    this.model.bind "change", this.render

  templateSelector : "#pin"
  tagName : "tr"

Rufinol.views.PinView = PinView
