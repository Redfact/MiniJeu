require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'


def clean_screen
	puts "\e[H\e[2J"
end

puts "-"*52
puts " |Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts " |Le but du jeu est d'être le dernier survivant !|"
puts "-"*52

puts "Donnez un nom a votre joueur"
name = gets.chomp
pl1 = HumanPlayer.new(name)

arraybot = []
arraybot << Player.new("Josiane")
arraybot << Player.new("José")

while( pl1.life_points > 0 && !arraybot.empty?)do
	pl1.show_state
	print"\n"*2

	puts "Quelle action veux-tu effectuer ?"
	puts "	a - chercher une meilleure arme "
	puts "	s - chercher à se soigner"
	puts "	q - pour quitter la partie"
	puts "Attaquer un joueur en vue :"
	arraybot.each_index { |i|  
		print "	", i," - ", arraybot[i] , "\n"
	}

	input = gets.chomp
	clean_screen
	case input
		when "a"
			pl1.search_weapon
		when "s"
			pl1.search_health_pack
	    when "q"
	    	break
	    else
	    	# Attribue les actions pour les joueurs restant
		    arraybot.each_index { |i|  
			if( input.to_i == i)then pl1.attacks(arraybot[i]) end
			arraybot[i].show_state
			if(arraybot[i].life_points <=0)then arraybot.delete_at(i) end
			if(arraybot.empty?)then break end
			}
	end

	#chaque bot attaque le joeur
	arraybot.each{ |bot|
		bot.attacks(pl1)
		pl1.show_state
	}


end

if (pl1.life_points <= 0 ) then 
	puts "Loser ! Tu as perdu !" 
else 
	puts "BRAVO ! TU AS GAGNE !" 
end
