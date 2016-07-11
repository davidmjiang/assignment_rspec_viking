require 'viking'

describe Viking do
  let(:v) {Viking.new("Red Orm", 95)}
  let(:axe) { Axe.new }
  let(:bow) { Bow.new }
  before(:each){allow(v).to receive(:puts)}

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
      max_health=enemy.health
      v.pick_up_weapon(bow)
      v.attack(enemy)
      expect(enemy.health).to be<(max_health)
    end

    it "calls the enemy's take damage method" do
      expect(enemy).to receive(:take_damage)
      v.attack(enemy)
    end

    context "attacking with no weapon" do

      it "calls damage_with_fists if attacking with no weapon" do
        expect(v).to receive(:damage_with_fists).and_return(10)
        v.attack(enemy)
      end

      it "deals strength * fists multiplier damage" do
        expect(enemy).to receive(:receive_attack).with(v.strength*0.25)
        v.attack(enemy)
      end
    end

    context "attacking with a weapon" do
      before(:each){v.pick_up_weapon(bow)}
      it "runs #damage_with_weapon" do
        expect(v).to receive(:damage_with_weapon).and_return(10)
        v.attack(enemy)
      end

      it "deals strength * weapon multiplier damage" do
        expect(enemy).to receive(:receive_attack).with(v.strength*2)
        v.attack(enemy)
      end

      context "attacking with a bow with no arrows" do
        it "attacks with fists" do
          empty_bow=Bow.new(0)
          expect(v).to receive(:damage_with_fists).and_return(2.5)
          v.pick_up_weapon(empty_bow)
          v.attack(enemy)
        end
      end
    end
  end
  describe "Viking dies" do
    it "raises an error if Viking dies" do
      expect{v.receive_attack(100)}.to raise_error("Red Orm has Died...")
    end
  end
end