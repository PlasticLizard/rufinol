Rufinol = this.Rufinol ||= {}
Rufinol.views ||= {}

class ViewBase extends Backbone.View
  initialize : (options) ->
    @templateSelector ||= options.templateSelector if options
    @template ||= Handlebars.compile(this.templateContent())

  templateContent : ->
    $(@templateSelector).html()

  renderTemplate : (data)->
    @template(data) if @template

  data : ->
    this.model.toJSON()

  render : ->
    rendered = this.renderTemplate(this.data())
    $(this.el).html(rendered)
    this


Rufinol.views.Base = ViewBase