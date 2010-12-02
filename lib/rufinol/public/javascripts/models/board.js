(function() {
  var Board;
  var __extends = function(child, parent) {
    var ctor = function(){};
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.prototype.constructor = child;
    if (typeof parent.extended === "function") parent.extended(child);
    child.__super__ = parent.prototype;
  };
  this.Rufinol || (this.Rufinol = {
    models: {}
  });
  Board = function() {
    return Backbone.Model.apply(this, arguments);
  };
  __extends(Board, Backbone.Model);
  this.Rufinol.models.Board = Board;
}).call(this);
