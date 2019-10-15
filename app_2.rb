require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/game'

def perform
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

  player1 = HumanPlayer.new(gets.chomp)

  #setup : creation of the enemies array
  enemies = []
  enemies << Player.new("José")
  enemies << Player.new("Josianne")

  while (!game_over?(player1,enemies)) do
  	system 'clear'
  	player1.show_state

  	#print du battle menu
  	puts "What to do ?"
  	puts "a - Find a better weapon ?"
  	puts "s - Find a health pack ?"
  	puts "Attack a player in sight :"
  	for n in 0..enemies.size-1 do
  		if(enemies[n].life_points >0) then
	  		puts "#{n} - #{enemies[n].name} who has #{enemies[n].life_points} HP left"
	  	end
  	end
  	user_input = "45"

  	while (user_input != "a") && (user_input !="s") && !user_input.to_i.between?(0,enemies.size-1) do
  		puts "Please select an action to perform"
  		print "> "
  		user_input = gets.chomp
  	end

  	case user_input
  	when "a"
  		player1.search_weapon
  	when "s"
  		player1.search_health_pack
  	else
  		if (user_input.to_i.between?(0,enemies.size-1)) then
  			player1.attacks(enemies[user_input.to_i])
  		end
  	end

  	#enemies turn
  	puts "#{player1.name} is under attack !!"
  	enemies.each {|enemy| enemy.attacks(player1) if enemy.life_points > 0 }
  	puts "Press enter to continue"
  	gets

  end

  (player1.life_points > 0)? (puts "Congratulation, you Won !!!") : (puts "You were defeated in battle, what a looser !")

end
#boolean check if the game is over
def game_over?(player1, enemies)
	return true if player1.life_points <= 0
	return true if enemies.select {|enemy| enemy.life_points > 0}.size == 0
	return false
end
perform
