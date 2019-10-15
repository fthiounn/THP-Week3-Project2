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
	def show_state
		puts "#{@name} has  #{@life_points} HP left"
	end
	def gets_damage (amount)
		@life_points -= amount
		if @life_points < 1 then 
			puts "Player #{@name} has been killed !"
		end
	end
	def attacks (player2)
		puts "Player #{@name} attacks player #{player2.name}"
		dmg = compute_damage
		puts "He deals #{dmg} damage points"
		player2.gets_damage(dmg)

	end
	def compute_damage
    	return rand(1..6)
  	end
end



