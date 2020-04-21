require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

player1 = Player.new("jojo")
player2 = Player.new("toto")


while( player1.life_points > 0 || player2.life_points > 0)do
	puts "Voici l'état des joueurs :"
	puts player1.show_state
	puts player2.show_state

	puts "Passons à la phase d'attaque :"
	player1.attacks(player2)
	if( player2.life_points <= 0 ) then break end

	player2.attacks(player1)	
	if( player1.life_points <= 0 ) then break end

end

binding.pry
