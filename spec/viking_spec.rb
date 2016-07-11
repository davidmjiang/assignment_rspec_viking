require 'viking'

describe Viking do
  let(:v) {Viking.new("Red Orm", 95)}
  let(:axe) { Axe.new }
  let(:bow) { Bow.new }

  describe "#initialize" do
    it "sets the name of a new viking" do
      expect(v.name).to eq("Red Orm")
    end

    it "sets the health attribute if specified" do
      expect(v.health).to eq(95)
    end

    it "has no weapon by default" do
      expect(v.weapon).to be(nil)
    end
  end

  describe "health" do
    it "does not allow health to be reassigned" do
      expect {v.health = 10}.to raise_error NoMethodError
    end
  end

  describe "#pick_up_weapon" do

    it "sets the viking's weapon" do
      v.pick_up_weapon(axe)
      expect(v.weapon).to eq(axe)
    end

    it "raises error if argument isn't a weapon" do
      expect { v.pick_up_weapon("Definitely not an axe") }.to raise_error "Can't pick up that thing"
    end

    it "replaces old weapon with the new weapon" do
      v.pick_up_weapon(axe)
      v.pick_up_weapon(bow)
      expect(v.weapon).to eql(bow)
    end
  end

  describe "#drop_weapon" do
    it "sets the weapon to nil" do
      v.pick_up_weapon(axe)
      v.drop_weapon
      expect(v.weapon).to be(nil)
    end
  end

  describe "#receive_attack" do
    it "reduces health by the specified amount" do
      v.receive_attack(10)
      expect(v.health).to eq(85)
    end

    it "calls the #take_damage method" do
      expect(v).to receive(:take_damage)
      v.receive_attack(10)
    end
  end

  describe "#attack" do
    let(:enemy) { Viking.new("Sven") }

    it "reduces the receipient's health" do
      v.pick_up_weapon(bow)
      v.attack(enemy)
      expect(enemy.health).to eq(80)
    end
  end
end