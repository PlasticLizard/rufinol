(function() {
  var PinView, Rufinol;
  var __bind = function(func, context) {
    return function(){ return func.apply(context, arguments); };
  }, __extends = function(child, parent) {
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
    return this.model.bind("change", __bind(function() {
      return this.render();
    }, this));
  };
  PinView.prototype.events = {
    "change .pin-mode": "pinModeChanged",
    "change .pin-value-editor": "pinValueChanged"
  };
  PinView.prototype.templateSelector = "#pin";
  PinView.prototype.tagName = "tr";
  PinView.prototype.render = function() {
    if (this.sliding) {
      return null;
    }
    PinView.__super__.render.apply(this, arguments);
    this.selectPinMode();
    this.renderPinValue();
    return this;
  };
  PinView.prototype.pinModeSelect = function() {
    return this.$(".pin-mode");
  };
  PinView.prototype.pinValueEditor = function() {
    return this.$(".pin-value-editor");
  };
  PinView.prototype.pinValueContainer = function() {
    return this.$(".pin-value");
  };
  PinView.prototype.pinEditorContainer = function() {
    return this.$(".pin-editor-container");
  };
  PinView.prototype.selectPinMode = function() {
    return this.pinModeSelect().val(this.model.get("mode"));
  };
  PinView.prototype.pinModeChanged = function() {
    var mode;
    mode = this.pinModeSelect().val();
    console.debug("Setting pin mode to " + (mode));
    return this.model.setPinMode(mode);
  };
  PinView.prototype.pinValueChanged = function() {
    var value;
    value = this.pinValueEditor().val();
    console.debug("Setting pin value to " + (value));
    return this.model.setPinValue(value);
  };
  PinView.prototype.renderPinValue = function() {
    var mode;
    mode = this.model.get("mode").toString();
    if (mode === "0") {
      return this.renderInputPinValue();
    } else if (mode !== "-1") {
      return this.renderOutputPinValue();
    }
  };
  PinView.prototype.renderOutputPinValue = function() {
    this.pinEditorContainer().css("width", "300px");
    this.pinEditorContainer().css("margin", "5px");
    this.pinEditorContainer().slider({
      orientation: "horizontal",
      range: "min",
      max: 100,
      value: 0,
      slide: __bind(function() {
        this.updatePinValue(this.pinEditorContainer().slider("value") / 100.0);
        return (this.sliding = true);
      }, this),
      change: __bind(function() {
        this.updatePinValue(this.pinEditorContainer().slider("value") / 100.0);
        return (this.sliding = false);
      }, this)
    });
    this.pinEditorContainer().slider("value", 100 * this.model.get("value"));
    return (this.ready = true);
  };
  PinView.prototype.updatePinValue = function(newValue) {
    var value;
    value = newValue.toString();
    if (value === this.model.get("value")) {
      return null;
    }
    if (this.ready) {
      return this.model.setPinValue(value);
    }
  };
  PinView.prototype.renderInputPinValue = function() {};
  Rufinol.views.PinView = PinView;
}).call(this);
