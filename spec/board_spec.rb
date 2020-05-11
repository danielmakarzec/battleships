require 'board'

RSpec.describe Board do
  context "New instance initialized" do
    it "has 10 rows" do
      board = Board.new
      expect(board.rows.size).to eq 10
    end
  end
end
