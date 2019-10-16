require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/game'


def perform
	my_game = Game.new(init, 100)
	while (my_game.is_still_ongoing?) do
		game_loop(my_game)
	end
	my_game.game_end
end

#the game loop
def game_loop(my_game)
	system 'clear'
	my_game.show_players
	my_game.menu
	user_input = -1
	while !user_check(user_input,my_game.enemies_in_sight.size) do
		puts "Please select an action to perform"
		print "> "
		user_input = gets.chomp
	end
	my_game.menu_choice(user_input)
	my_game.enemies_attack
	my_game.new_players_in_sight
	my_game.show_players
	gets
end
#the welcome screen and setting of the player name
def init
	system 'clear'
	puts "     _,.
    ,` -.)
   ( _/-\\\\-._
  /,|`--._,-^|            ,
  \\_| |`-._/||          ,'|
    |  `-, / |         /  /
    |     || |        /  /
     `r-._||/   __   /  /   _______ ________  _     _   ____
 __,-<_     )`-/  `./  /   / ___  / \\  ___ /  \\|   |/  / __ \\
'  \\   `---'   \\   /  /    ``  / /   ||   `   ||   || | <__``
    |           |./  /       _/ /   < |==|    ||   ||  \\__ `\\
    /           //  /       / /`     ||       ||   ||     `\\ |
\\_/' \\         |/  /       / /___,,  ||___,   \\ \\_/ / |\\___/ /
 |    |   _,^-'/  /       /_______/ /______\\   \\___/  \\_____/
 |    , ``  (\\/  /_
  \\,.->._    \\X-=/^            Welcome to the game Zeus
  (  /   `-._//^`              Be the last survivor !
   `Y-.____(__}				
    |     {__)
          ()"
  #setup : creation of the Human Player
  puts "Please name your player :"
  print "> "
	return gets.chomp
end
def user_check(str,nb_enemy)
	if(str == "a")
		return true
	elsif str == "s"
		return true
	else
		nb_enemy.times do |n|
			if str == n.to_s 
				return true
			end
		end
	end
	return false
end
perform