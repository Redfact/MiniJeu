require_relative '../lib/player'
require 'colorize'
require 'colorized_string'


class Game
	attr_accessor :human_player ,:ennemies,:players_left

	


	def initialize(name)
		@human_player = HumanPlayer.new(name)
		@ennemies =[]
		@players_left = 10
	end

	def kill_player(player)
		@ennemies.delete_at(@ennemies.index(player))
	end

	def is_still_ongoing?
		return @human_player.life_points > 0 && (!ennemies.empty? || @players_left>0 )
	end

	def show_players
		nb_en = ColorizedString.new("#{@ennemies.size}").red
		nb_surv = ColorizedString.new("#{@players_left+@ennemies.size}").red
		puts @human_player.show_state
		puts "Il y #{nb_en} ennemies en vue et #{nb_surv} survivants"
	end

	def menu
		puts "Quelle action veux-tu effectuer ?"
		puts "	a - chercher une meilleure arme "
		puts "	s - chercher à se soigner"
		puts "Attaquer un joueur en vue :"
		@ennemies.each_index { |i|  
			print "	", i," - ", @ennemies[i] , "\n"}
	end

	def menu_choice
	 	input = gets.chomp
		case input
			when "a"
				@human_player.search_weapon
			when "s"
				@human_player.search_health_pack
		    else
		    	# Attribue les actions pour les joueurs restant
			    @ennemies.each_index{ |i|  
				if( input.to_i == i)then 
					foe = @ennemies[i]
					@human_player.attacks(foe) 
					@ennemies[i].show_state
				end
				if(@ennemies[i].life_points <=0)then 
					kill_player(foe)
					foe.show_state
				end
				}
				if(@ennemies.empty?)then puts "Pas d'ennemies en vue" end
		end 
	end

	def enemies_attack
		@ennemies.each{ |bot|
		bot.attacks(@human_player)
		@human_player.show_state}
	end

	def new_players_in_sight
		rand_val = rand(1..6)
		case rand_val
		when 1
			puts "Pas d'enemies en vue"
		when 2..4
			@ennemies<<Player.new("bot#{@ennemies.size}#{rand(1..10)}")
			@players_left -= 1
		when 5..6
			@ennemies<<Player.new("bot#{@ennemies.size}#{rand(1..10)}")
			@ennemies<<Player.new("bot#{@ennemies.size}#{rand(1..10)}")
			@players_left -= 2
		end
	end

	def end
		if(@human_player.life_points>0)then msg ="Tu as gagné !".colorize(:green) else msg = "Tu as perdu, tu feras mieux la prochaine fois".colorize(:red)end
		puts "-"*52
		puts " 	|La partie est terminée !|"
		puts " 	|#{msg}|"
		puts "-"*52	
	end	
end
