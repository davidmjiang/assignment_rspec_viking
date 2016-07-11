require 'weapons/bow'

describe Bow do
  describe "arrow_count" do
    it "is able to read the number of arrows" do
      expect{subject.arrows}.to_not raise_error
    end
    it "should start with 10 arrows by default" do
      expect(subject.arrows).to eql(10)
    end
    context "when number of arrows is specified" do
      let(:custom_bow){Bow.new(20)}
      it "should set arrows to specified number" do
        expect(custom_bow.arrows).to eql(20)
      end
    end
  end

  describe "#use" do
    it "reduces arrow count by 1" do
      subject.use
      expect(subject.arrows).to eql(9)
    end
    context "when arrow count is 0" do
      let(:empty_bow){Bow.new(0)}
      it "should not fire" do
        expect{empty_bow.use}.to raise_error("Out of arrows")
      end
    end
  end
end