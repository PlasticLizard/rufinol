(function() {
  var Rufinol;
  Rufinol = this.Rufinol;
  describe("Base", function() {
    var view;
    view = null;
    beforeEach(function() {
      var model;
      setFixtures("<div id='template'>Oh, {{hi}} {{there}}</div>");
      model = new Backbone.Model({
        hi: "Hello",
        there: "Friend"
      });
      return (view = new Rufinol.views.Base({
        model: model,
        templateSelector: "#template"
      }));
    });
    it("should able to be instantiated", function() {
      expect(view).toBeDefined();
      return expect(view).not.toBeNull();
    });
    describe("#initialize", function() {
      it("should set the templateSelector property from the options when provided", function() {
        return expect(view.templateSelector).toEqual("#template");
      });
      return it("should compile a template from content found via the templateSelector", function() {
        return expect(typeof (view.template)).toEqual("function");
      });
    });
    describe("templateContent", function() {
      return it("should return the contents of the templateSelector", function() {
        return expect(view.templateContent()).toEqual("Oh, {{hi}} {{there}}");
      });
    });
    describe("renderTemplate", function() {
      return it("should render the compiled template", function() {
        return expect(view.renderTemplate({
          hi: "HI",
          there: "THERE"
        }).toEqual);
      });
    });
    describe("data", function() {
      return it("should provide a hash of model attributes", function() {
        return expect(view.data()).toEqual({
          hi: "Hello",
          there: "Friend"
        });
      });
    });
    return describe("render", function() {
      beforeEach(function() {
        return view.render();
      });
      return it("should render the template and set the results into the views element", function() {
        return expect($(view.el).html()).toEqual("Oh, Hello Friend");
      });
    });
  });
}).call(this);
