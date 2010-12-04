Rufinol = this.Rufinol

describe "Base", ->
  view = null

  beforeEach ->
    setFixtures "<div id='template'>Oh, {{hi}} {{there}}</div>"
    model = new Backbone.Model { hi : "Hello", there : "Friend" }
    view = new Rufinol.views.Base(model : model, templateSelector : "#template")

  it "should able to be instantiated", ->
    expect(view).toBeDefined()
    expect(view).not.toBeNull()

  describe "#initialize", ->
    it "should set the templateSelector property from the options when provided", ->
      expect(view.templateSelector).toEqual "#template"

    it "should compile a template from content found via the templateSelector", ->
      expect(typeof(view.template)).toEqual "function"

  describe "templateContent", ->
    it "should return the contents of the templateSelector", ->
      expect(view.templateContent()).toEqual "Oh, {{hi}} {{there}}"

  describe "renderTemplate", ->
    it "should render the compiled template", ->
      expect(view.renderTemplate(hi : "HI", there : "THERE").toEqual "Oh, HI THERE"

  describe "data", ->
    it "should provide a hash of model attributes", ->
      expect(view.data()).toEqual {hi : "Hello", there : "Friend" }

  describe "render", ->
    beforeEach -> view.render()
    it "should render the template and set the results into the views element", ->
      expect($(view.el).html()).toEqual "Oh, Hello Friend"