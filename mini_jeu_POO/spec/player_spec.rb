require_relative '../lib/player'

player1 = Player.new("jojo")
player2 = Player.new("toto")

describe "Gets damage" do 
	it "sub player life points"do 
	player1.gets_damage(1)
	expect(player1.life_points).to eq(19)
	end
end

describe "attacks" do 
	it "Player1 gets damages from Player2"do
	life = player1.life_points
	damage_value = player2.attacks(player1)
	expect(player1.life_points).to eq(life - damage_value)
	end
end

