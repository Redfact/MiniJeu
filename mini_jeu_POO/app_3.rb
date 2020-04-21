require 'bundler'
Bundler.require
require 'colorize'


require_relative 'lib/game'
require_relative 'lib/player'

#Enleve tous le text affiché sur le terminal
def clean_screen
	puts "\e[H\e[2J"
end

clean_screen
puts "-".colorize(:green) *52
puts " |Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |".colorize(:green)
puts " |Le but du jeu est d'être le dernier survivant !|".colorize(:green)
puts "-".colorize(:green) *52

puts "Donnez un nom a votre joueur"
name = gets.chomp
my_game = Game.new(name)

while (my_game.is_still_ongoing?)do
	clean_screen
	if( my_game.players_left > 0)then my_game.new_players_in_sight end
	my_game.show_players
	my_game.menu
	my_game.menu_choice
	my_game.enemies_attack
end
clean_screen
my_game.end
