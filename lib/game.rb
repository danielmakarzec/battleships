# frozen_string_literal: true

require_relative './ships.rb'
require_relative './board.rb'

# loop:
## check if there are any ships left to strike.
#### If not: end the game with the 'win' message.
## initialize the board.
#### change the chosen 'hit-box' symbol acordingly.
## ask for the 'hit-box' coordinates to strike. i.e. 'c4'
class Game
  def initialize
    @picks = []                           # player targeted coordinates
    @hit = []                             # player succesful strikes
    @rows = Board.new.rows
    @ships = Ships.new.generate_all_ships
    @chances = 60                         # number of chances player have to win
  end

  def play
    until @hit.size == 20 || @chances.zero?
      board
      counter
      puts "Chances left: #{@chances}"
      @chances -= 1
      ask
      system 'clear'
    end
    board
    @hit.size == 20 ? win : lose
  end

  def board
    puts '     1  2  3  4  5  6  7  8  9  10'
    @rows.each do |row|
      print " #{row.first.slice(0)}: "
      row.each do |column|
        if @picks.include? column
          if @ships.include? column
            print ' X '
          else
            print ' ~ '
          end
        elsif @ships.include?(column) && @chances.zero?
          print ' O '
        else
          print " \u00B7 "
        end
      end
      puts " :#{row.first.slice(0)} "
    end
    puts '     1  2  3  4  5  6  7  8  9  10'
  end

  def counter
    puts "Current Score: #{@hit.size}"
  end

  def ask
    puts ''
    puts 'Pick a field to strike'
    @picks << gets.chomp.downcase
    @hit << @picks.last if @ships.include? @picks.last
  end

  def win
    puts 'You win! Congrats!!'
    exit
  end

  def lose
    puts 'You lost!'
    print "Your final score is #{@hit.size}."
    print ' So close. ' unless @hit.size < 17
    print 'Try again.'
    exit
  end
end
