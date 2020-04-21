require 'colorize'
require 'colorized_string'

class Player
	attr_accessor :name ,:life_points

	def initialize(nm)
		@name = nm 
		@life_points = 10	
	end

	def show_state
		nm = ColorizedString.new("#{@name}").blue
		life = ColorizedString.new("#{@life_points}").green
		puts "#{nm} a #{life} point de vie"
	end

	def to_s
		return "#{@name} Life: #{@life_points}"
	end

	def gets_damage(dmgpoint)
		@life_points -=dmgpoint
		if( @life_points <= 0 ) then
			puts "#{@name} a été tué !"
		end 
	end

	def compute_damage
		return rand(1..6)
	end

	def attacks(otherplayer)
		val_damage = compute_damage
		puts "#{@name} inflige #{val_damage} point de dégat à #{otherplayer.name}"
		otherplayer.gets_damage(val_damage)
		return val_damage
	end

end

class HumanPlayer < Player
	attr_accessor :weapon_level

	def initialize(nm)
		super
		@life_points = 100
		@weapon_level = 1
	end

	def show_state
		nm = ColorizedString.new("#{@name}").blue
		life = ColorizedString.new("#{@life_points}").green
		wp = ColorizedString.new("#{@weapon_level}").green
		puts "#{nm} a #{life} points de vie et une arme de niveau #{wp}"
	end

	def to_s
		return "Life: #{@life_points} Weapon level: #{@weapon_level}"
	end

	def compute_damage
		return rand(1..6) * @weapon_level
	end

	def search_weapon
		val =rand(1..6)
		puts "Tu as trouvé une arme de niveau #{val}"
		if( val > @weapon_level) then 
			@weapon_level = val 
			puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
		elsif (val <= @weapon_level)
			puts  "M@*#$... elle n'est pas mieux que ton arme actuelle..." 
		end
	end

	def search_health_pack
		val =rand(1..6)
		case val 
			when 1
				puts "Tu n'as rien trouvé... "
			when 2..5
				puts "Bravo, tu as trouvé un pack de +50 points de vie !"
				@life_points +=50
				if ( @life_points>100)then @life_points=100 end
			when 6
			  	puts "Waow, tu as trouvé un pack de +80 points de vie !"
			  	@life_points +=80
				if ( @life_points>100)then @life_points=100 end
			end
	end
end