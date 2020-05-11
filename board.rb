# frozen_string_literal: true

# 10x10 board. To change the size of a board add or take a letter from the @columns array.
class Board
  def initialize
    @rows = []
    @columns = %w[a b c d e f g h i j]
  end

  # for each column create number rows equal to the number of columns
  def rows
    @columns.each do |column|
      @rows << Array.new(@columns.size) do |i|
        "#{column}#{i + 1}"
      end
    end
    @rows
  end
end
