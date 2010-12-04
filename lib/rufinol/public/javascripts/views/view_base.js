(function() {
  var Rufinol, ViewBase;
  var __extends = function(child, parent) {
    var ctor = function(){};
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.prototype.constructor = child;
    if (typeof parent.extended === "function") parent.extended(child);
    child.__super__ = parent.prototype;
  };
  Rufinol = this.Rufinol || (this.Rufinol = {});
  Rufinol.views || (Rufinol.views = {});
  ViewBase = function() {
    return Backbone.View.apply(this, arguments);
  };
  __extends(ViewBase, Backbone.View);
  ViewBase.prototype.initialize = function(options) {
    if (options) {
      this.templateSelector || (this.templateSelector = options.templateSelector);
    }
    return this.template || (this.template = Handlebars.compile(this.templateContent()));
  };
  ViewBase.prototype.templateContent = function() {
    return $(this.templateSelector).html();
  };
  ViewBase.prototype.renderTemplate = function(data) {
    if (this.template) {
      return this.template(data);
    }
  };
  ViewBase.prototype.data = function() {
    return this.model.toJSON();
  };
  ViewBase.prototype.render = function() {
    var rendered;
    rendered = this.renderTemplate(this.data());
    $(this.el).html(rendered);
    return this;
  };
  Rufinol.views.Base = ViewBase;
}).call(this);
