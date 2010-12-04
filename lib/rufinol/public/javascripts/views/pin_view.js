(function() {
  var PinView, Rufinol;
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
  PinView = function() {
    return Rufinol.views.Base.apply(this, arguments);
  };
  __extends(PinView, Rufinol.views.Base);
  PinView.prototype.initialize = function(options) {
    PinView.__super__.initialize.call(this, options);
    _.bindAll(this, 'render');
    return this.model.bind("change", this.render);
  };
  PinView.prototype.templateSelector = "#pin";
  PinView.prototype.tagName = "tr";
  Rufinol.views.PinView = PinView;
}).call(this);
