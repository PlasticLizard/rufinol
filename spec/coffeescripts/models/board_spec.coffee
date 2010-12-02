Rufinol = this.Rufinol

describe "Board", ->
  board = null

  beforeEach -> board = new Rufinol.models.Board

  it "should able to be instantiated", ->
    expect(board).toBeDefined()
    expect(board).not.toBeNull()
