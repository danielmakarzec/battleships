# frozen_string_literal: true

# random ships generator.
# a ship can take between one to four fields on the board.
# It can be oriented verticaly or horizontaly.
# It's location on the borad is random but cant protrude beyond it.
class Ships
  def initialize
    @set = %w[vertical horizontal]
    @total_fields_taken = []
    @ships = []
  end

  def generate_all_ships
    add_ship(4)
    2.times { add_ship(3) }
    3.times { add_ship(2) }
    4.times { add_ship(1) }
    @ships
  end

  def add_ship(num_of_masts)
    avalible = false
    while avalible == false
      ship = ship(num_of_masts)
      position_taken = ship.select { |mast_position| @total_fields_taken.include? mast_position }
      avalible = position_taken.empty?
    end

    @ships += ship

    fields_around(ship)
  end

  def fields_around(ship)
    ship.each do |mast_position|
      row_before = (mast_position.slice(0).ord - 1).chr
      row_after = (mast_position.slice(0).ord + 1).chr

      @total_fields_taken << "#{row_before}#{mast_position.slice 1}" unless row_before == '`'
      @total_fields_taken << mast_position
      @total_fields_taken << "#{row_after}#{mast_position.slice 1}" unless row_after == 'k'

      column_before = mast_position.slice(1).to_i - 1
      column_after = mast_position.slice(1).to_i + 1

      @total_fields_taken << "#{mast_position.slice 0}#{column_before}" unless column_before < 1
      @total_fields_taken << "#{mast_position.slice 0}#{column_after}" unless column_after > 10
    end
  end

  def ship(num_of_masts)
    random = Random.new
    column = random.rand 1..(11 - num_of_masts)
    row = ('a'..'k').to_a
    row.pop(num_of_masts)
    char = row.sample

    if @set.sample == 'horizontal'
      Array.new(num_of_masts) { |mast_num| "#{(char.ord + mast_num).chr}#{column}" }
    else
      Array.new(num_of_masts) { |mast_num| "#{char}#{column + mast_num}" }
    end
  end
end
