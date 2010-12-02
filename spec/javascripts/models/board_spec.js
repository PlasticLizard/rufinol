(function() {
  var Rufinol;
  Rufinol = this.Rufinol;
  describe("Board", function() {
    var board;
    board = null;
    beforeEach(function() {
      return (board = new Rufinol.models.Board());
    });
    return it("should able to be instantiated", function() {
      expect(board).toBeDefined();
      return expect(board).not.toBeNull();
    });
  });
}).call(this);
