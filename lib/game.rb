#SPECIFICATIONS Class game.rb
#Voici ce que tu dois faire dans la classe Game (80 % du travail consiste à rapatrier 
#du code depuis app_2.rb) :

#Crée la classe Game qui aura 2 attr_accessor : un @human_player de type HumanPlayer 
#et un array @enemies qui contiendra des Player.

# ¿WHY?
# Cette Classe doit gerer les menu du jeu, ainsi que les processus de combat

class Game
	attr_accessor :human_player, :enemies_in_sight, :players_left
	#Un objet Game s'initialise ainsi : my_game = Game.new("Wolverine"). Il crée automatiquement 4 Player qu'il met dans @enemies et un HumanPlayer portant (dans cet exemple) le nom "Wolverine".
	def initialize (name,nb)
		@players_left = nb
		@human_player = HumanPlayer.new(name)
		@enemies_in_sight = []
		5.times do |n|
			@enemies_in_sight << Player.new("Enemy #{n}")
		end
		@players_left
	end
	#Cette méthode permet d'éliminer un adversaire tué.
	def kill_player(player)
		@enemies_in_sight.reject! {|k| k.name == player.name}
		@players_left-=1
	end
	#Écris une méthode is_still_ongoing? qui retourne true si le jeu est toujours en cours et false 
	#sinon. Le jeu continue tant que le @human_player a encore des points de vie et qu'il reste des 
	#Player à combattre dans l’array @enemies.
	def is_still_ongoing?
		return false if @human_player.life_points <= 0
		return false if ((@enemies_in_sight.select {|enemy| enemy.life_points > 0}.size == 0) && @players_left==0)
		return true
	end
	#Écris une méthode show_players qui va afficher 1) l'état du joueur humain et 2) le nombre de 
	#joueurs "bots" restant
	def show_players
		puts "#{@human_player.name} has #{@human_player.life_points} HP and a lvl #{@human_player.weapon_level} weapon"
		puts "There is still #{@enemies_in_sight.size} remaining enemies in sight and #{@players_left} over all"
	end
	#Écris une méthode menu qui va afficher le menu de choix (juste l'afficher, pas plus). On a les 
	#mêmes choix que dans la version 2.0 à la seule différence qu'il y a plus de 2 ennemis à combattre 
	#et que si un ennemi est mort, on ne doit plus proposer de l'attaquer.
	def menu
		puts "What to do ?"
	  	puts "a - Find a better weapon ?"
	  	puts "s - Find a health pack ?"
	  	puts "Attack a player in sight :"
	  	for n in 0..@enemies_in_sight.size-1 do
	  		if(@enemies_in_sight[n].life_points >0) then
		  		puts "#{n} - #{@enemies_in_sight[n].name} who has #{@enemies_in_sight[n].life_points} HP left"
		  	end
	  	end
	end
	#Écris une méthode menu_choice qui prend en entrée un string. Cette méthode va permettre de faire 
	#réagir le jeu en fonction du choix, dans le menu, de l'utilisateur. Par exemple, si l'entrée est 
	#{}"a", le @human_player doit aller chercher une arme. Si l'entrée est "0", on le fait attaquer 
	#l'ennemi présenté au choix "0", etc. Pense à faire appel, dans cette méthode, à la méthode kill_player 
	#si jamais un Player est tué par le joueur humain !
	def menu_choice (str)
		case str
  	when "a"
  		@human_player.search_weapon
  	when "s"
  		@human_player.search_health_pack
  	else
  		if (str.to_i.between?(0,@enemies_in_sight.size-1)) then
  			@human_player.attacks(@enemies_in_sight[str.to_i])
  			if @enemies_in_sight[str.to_i].life_points <=0 then
  				kill_player(@enemies_in_sight[str.to_i])
  			end
  		end
  	end
	end
	#Écris une méthode enemies_attack qui va faire riposter tous les ennemis vivants. Ils vont attaquer à 
	#tour de rôle le joueur humain.
	def enemies_attack
		puts "#{@human_player.name} is under attack !!"
  	@enemies_in_sight.each {|enemy| enemy.attacks(@human_player) if is_still_ongoing?}
	end
	#Écris une méthode end qui va effectuer l'affichage de fin de jeu. Tu sais, la partie "le jeu est fini" 
	#puis "Bravo..." ou "Loser..."
	def game_end
		puts "The game is over"
		if(@human_player.life_points > 0) && (@enemies_in_sight.size == 0)
			puts "Congratulation, you Won !!!"
		else
			puts "You were defeated in battle, what a looser !"
		end
	end
#Crée une méthode new_players_in_sight qui va avoir pour rôle de rajouter des ennemis en vue. 
#Voici les règles de fonctionnement de cette méthode :
#Si tous les joueurs du jeu sont déjà "en vue", on ne doit pas en rajouter. Dans ce cas, cela 
#signifie que le nombre d'objets Player dans @enemies_in_sight est égal à l'integer @players_left. 
#Affiche alors un message d'info du type "Tous les joueurs sont déjà en vue".
#La méthode va lancer un dé à 6 faces et va réagir en fonction de ce résultat aléatoire :
#Si le dé vaut 1, aucun nouveau joueur adverse n'arrive (afficher un message informant l'utilisateur).
#Si le dé vaut entre 2 et 4 inclus, un nouvel adversaire arrive en vue. Il faut alors créer un Player 
#avec un nom aléatoire du genre "joueur_1234" ou "joueur_6938" (ou ce que tu veux) et injecter ce Player 
#dans le array @enemies_in_sight . Affiche un message informant l'utilisateur de ce qui se passe.
#Si le dé vaut 5 ou 6, cette fois c'est 2 nouveaux adversaires qui arrivent en vue. De même qu'au-dessus, 
#il faut les créer et les rajouter au jeu. Rajoute toujours un message informant l'utilisateur.
	def new_players_in_sight
		if @players_left == @enemies_in_sight.size
			puts "All enemies are already in sight"
		else
			nb_enemy = rand(1..6)
			if(nb_enemy < 3)
				puts "No new enemy appear this round"
			elsif nb_enemy < 5
				puts "A new enemy appear !!"
				@enemies_in_sight << Player.new("Enemy #{enemies_in_sight.size}")
			else
				puts "Two new enemies appear"
				2.times do |n|
					@enemies_in_sight << Player.new("Enemy #{enemies_in_sight.size+n}")
				end
			end
					
		end
	end
end











