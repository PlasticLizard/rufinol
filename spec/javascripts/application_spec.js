(function() {
  var Rufinol, test_data;
  Rufinol = this.Rufinol;
  test_data = Rufinol.test_data.board;
  describe("Application", function() {
    var application;
    application = null;
    beforeEach(function() {
      setFixtures("<p id='board'>{{hi}}</p><p id='port'>{{hi}}</p><p id='pin'>{{hi}}</p>");
      spyOn(_, "bindAll").andReturn();
      return (application = new Rufinol.views.Application({
        boardData: test_data.board,
        webSocketUri: "ws"
      }));
    });
    describe("initialize", function() {
      it("should bind socket events", function() {
        return expect(_.bindAll).toHaveBeenCalledWith(application, "onSocketMessage", "onSocketOpen", "onSocketClose");
      });
      it("should set the board model from provided data", function() {
        expect(application.board).toBeDefined();
        return expect(application.board).not.toBeNull();
      });
      it("should set the board view from the initialized model", function() {
        expect(application.boardView).not.toBeNull();
        return expect(application.boardView.model).toEqual(application.board);
      });
      it("should set the 'el' property to the document body", function() {
        return expect($(application.el)).toBe("body");
      });
      return it("should set the webSocketUri property from options", function() {
        return expect(application.webSocketUri).toEqual("ws");
      });
    });
    describe("start", function() {
      beforeEach(function() {
        spyOn(application, "render").andReturn();
        spyOn(application, "initializeWebSockets").andReturn();
        return application.start();
      });
      it("should call render", function() {
        return expect(application.render).toHaveBeenCalled();
      });
      return it("should call initializeWebSockets", function() {
        return expect(application.initializeWebSockets).toHaveBeenCalled();
      });
    });
    describe("render", function() {
      var boardView;
      boardView = {
        render: function() {
          return {
            el: "hi"
          };
        }
      };
      beforeEach(function() {
        application.boardView = boardView;
        spyOn(application.el, "append");
        return application.render();
      });
      return it("should append the rendered boardView to its element", function() {
        return expect(application.el.append).toHaveBeenCalledWith("hi");
      });
    });
    describe("initializeWebSockets", function() {
      beforeEach(function() {
        application.socket = {};
        return application.initializeWebSockets();
      });
      return it("should subscribe to socket events", function() {
        expect(application.socket.onmessage).toEqual(application.onSocketMessage);
        expect(application.socket.onclose).toEqual(application.onSocketClose);
        return expect(application.socket.onopen).toEqual(application.onSocketOpen);
      });
    });
    describe("sending commands to the server", function() {
      beforeEach(function() {
        application.socket = {
          send: function() {}
        };
        return spyOn(application.socket, "send").andReturn();
      });
      describe("sendPinMode", function() {
        var pin;
        pin = {
          id: "123",
          get: function() {
            return 100;
          }
        };
        beforeEach(function() {
          spyOn(pin, "get").andReturn("100");
          return application.sendPinMode(pin);
        });
        it("should get the pin mode from the pin", function() {
          return expect(pin.get).toHaveBeenCalledWith("mode");
        });
        return it("should send the setPinMode command", function() {
          var expectedMessage;
          expectedMessage = JSON.stringify({
            command: "setPinMode",
            pin: pin.id,
            mode: "100"
          });
          return expect(application.socket.send).toHaveBeenCalledWith(expectedMessage);
        });
      });
      return describe("sendPinValue", function() {
        var pin;
        pin = {
          id: "123",
          get: function() {
            return 1.0;
          }
        };
        beforeEach(function() {
          spyOn(pin, "get").andReturn("1.0");
          return application.sendPinValue(pin);
        });
        it("should get the pin value from the pin", function() {
          return expect(pin.get).toHaveBeenCalledWith("value");
        });
        return it("should send the setPinValue command", function() {
          var expectedMessage;
          expectedMessage = JSON.stringify({
            command: "setPinValue",
            pin: pin.id,
            value: "1.0"
          });
          return expect(application.socket.send).toHaveBeenCalledWith(expectedMessage);
        });
      });
    });
    return describe("onSocketMessage", function() {
      beforeEach(function() {
        var message;
        spyOn(application.board, "updatePin");
        message = {
          data: JSON.stringify({
            hi: "there"
          })
        };
        return application.onSocketMessage(message);
      });
      return it("should call @board.updatePin with parsed pin data", function() {
        return expect(application.board.updatePin).toHaveBeenCalledWith({
          hi: "there"
        });
      });
    });
  });
}).call(this);
