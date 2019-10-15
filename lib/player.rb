#SPECIFICATIONS class Player
#Quand on s'attaque à un gros morceau comme Fortnite, il y a un max de fonctionnalités 
#qu'on peut avoir envie de coder. Alors pour ne pas se perdre, commençons par quelque chose
# qui soit à la fois relativement simple à coder et central au jeu. Ici, j'ai choisi de te 
#faire commencer par un combat. Tout simplement. Si on est pas capable de coder un combat 
#entre 2 personnages, on ne saura pas coder ce jeu : commençons donc par ça !

#Que faut-il pour faire un combat ? Moi j'ai en tête qu'il faut a minima :

#2 joueurs ;
#Que chaque joueur ait un niveau de vie donné ;
#Que ce niveau de vie baisse à chaque attaque subie ;
#Si la vie atteint zéro, le personnage est mort.

#Difficile de faire plus simple... Alors allons-y ! On va commencer par coder tout ça dans 
#le fichier player.rb qui va donc accueillir la classe Player dont le but est de modéliser 
#un joueur. Je vais te décrire chaque caractéristique d'un objet Player, charge à toi d'écrire le code !


# ¿WHY?

#This class implements a player and his attributes, a player is meant to interact 
#with other players in a battle system


class Player
	#atttributes
	attr_accessor :name, :life_points
	#constructor
	def initialize (name)
		@name = name
		@life_points = 10
	end
	#¿WHY? displays the player HP
	def show_state
		puts "#{@name} has  #{@life_points} HP left"
	end
	#¿WHY? apply damage to the player
	def gets_damage (amount)
		@life_points -= amount
		if @life_points < 1 then 
			puts "Player #{@name} has been killed !"
		end
	end
	#¿WHY? launch an atatck against another player
	def attacks (player2)
		puts "Player #{@name} attacks player #{player2.name}"
		dmg = compute_damage
		puts "He deals #{dmg} damage points"
		player2.gets_damage(dmg)
  
	end
	#¿WHY? generate randomly the damage dealt
	def compute_damage
    	return rand(1..6)
  	end
end
#¿WHY? Class HumanPlayer inherit from Class Player, this class will differenciate an actual player from
# monsters
class HumanPlayer < Player
	attr_accessor :weapon_level
	#overloaded constructor
  	def initialize(name)
    	super(name)        # appel au constructeur de la classe Player
    	@life_points = 100
    	@weapon_level = 1
    end
    #¿WHY? displays the player HP
    def show_state
    	puts "#{@name} has #{@life_points} HP and a lvl #{@weapon_level} weapon"
    end
    #¿WHY? generate randomly the damage dealt with the @weapon_level factor
    def compute_damage
        rand(1..6) * @weapon_level
    end
    #¿WHY? generates a random weapon and equip it if its better than current one
    def search_weapon
    	new_weapon_lvl = rand(1..6)
    	puts "You found a lvl #{new_weapon_lvl} weapon"
    	if new_weapon_lvl > @weapon_level then
    		@weapon_level = new_weapon_lvl
    		puts "Yeah ! This weapon is better than your current weapon : you equiped the lvl "+"#{@weapon_level}".green + "weapon"
    	else
    		puts "Your current weapon is stronger :( too bad"
    	end
    end
    #¿WHY? generates a random health pack and uses it
    def search_health_pack
    	tmp = 0
    	health_pack = rand(1..6)
    	if health_pack == 1 then
    		puts "No health pack found"
    	elsif health_pack < 6 then
    		tmp = 50
    		@life_points = life_points + 50
    		if life_points > 100 then
    			tmp = 50 - (life_points - 100)
    			@life_points = 100
    		end
    		puts "Yeah, you found a +"+"50".green+" health pack ! You gained +"+"#{tmp}".green+" HP"
    	else
    		@life_points = life_points + 80
    		tmp = 80
    		if life_points > 100 then
    			tmp = 80 - (life_points - 100)
    			@life_points = 100
    		end
    		puts "Yeah, you found a +"+"80".green+" health pack ! You gained +"+"#{tmp}".green+" HP"
    	end
    end
end













