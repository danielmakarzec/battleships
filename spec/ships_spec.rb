require 'ships'

RSpec.describe Ships do
  let(:ships) { Ships.new }

  it 'returns 10 ships of total number of masts eq 20' do
    ships.generate_all_ships
    expect(ships.ships.size).to eq 20
  end

  context 'Every created ship' do
    it 'has between 1 - 4 masts' do
      r = rand(1..4)
      ship = ships.ship(r)
      expect(ship.size).to eq r
    end
  end
  context 'Two ships can not be positioned directly next to each other' do
    it 'takes 3 filelds from the board if the ship has 1 masts and is in the corner' do
      ships.fields_around(["a1"])
      taken_fields = ships.total_fields_taken.uniq
      expect(taken_fields.size).to eq 3
    end
    it 'takes 5 filelds from the board if the ship has 2 masts and is in the corner' do
      ships.fields_around(["j9","j10"])
      taken_fields = ships.total_fields_taken.uniq
      expect(taken_fields.size).to eq 5
    end
    it 'takes 11 filelds from the board if the ship has 3 masts and is in the center' do
      ships.fields_around(["e5","f5","g5"])
      taken_fields = ships.total_fields_taken.uniq
      expect(taken_fields.count).to eq 11
    end
  end
end
