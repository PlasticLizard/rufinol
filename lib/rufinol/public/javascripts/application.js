(function() {
  var Application, Rufinol;
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
  Application = function() {
    return Backbone.View.apply(this, arguments);
  };
  __extends(Application, Backbone.View);
  Application.prototype.initialize = function(options) {
    var boardData;
    _.bindAll(this, "onSocketMessage", "onSocketOpen", "onSocketClose");
    if (options) {
      boardData = options.boardData;
    }
    this.board = new Rufinol.models.Board(boardData);
    this.boardView = new Rufinol.views.BoardView({
      model: this.board
    });
    this.el = $("body");
    this.webSocketUri = options.webSocketUri;
    return this;
  };
  Application.prototype.start = function() {
    this.render();
    this.initializeWebSockets();
    return this;
  };
  Application.prototype.render = function() {
    this.el.append(this.boardView.render().el);
    return this;
  };
  Application.prototype.initializeWebSockets = function() {
    this.socket || (this.socket = new WebSocket(this.webSocketUri));
    this.socket.onmessage = this.onSocketMessage;
    this.socket.onclose = this.onSocketClose;
    return (this.socket.onopen = this.onSocketOpen);
  };
  Application.prototype.sendPinMode = function(pin) {
    var command;
    command = {
      command: "setPinMode",
      pin: pin.id,
      mode: pin.get("mode")
    };
    return this.socket.send(JSON.stringify(command));
  };
  Application.prototype.sendPinValue = function(pin) {
    var command;
    command = {
      command: "setPinValue",
      pin: pin.id,
      value: pin.get("value")
    };
    return this.socket.send(JSON.stringify(command));
  };
  Application.prototype.onSocketMessage = function(message) {
    var pinData;
    pinData = JSON.parse(message.data);
    return this.board.updatePin(pinData);
  };
  Application.prototype.onSocketClose = function() {
    return console.log("Rufinol has closed its connection with your device server");
  };
  Application.prototype.onSocketOpen = function() {
    return console.log("Rufinol is now connected to your device server");
  };
  Rufinol.views.Application = Application;
}).call(this);
