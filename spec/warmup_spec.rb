require "warmup"

describe Warmup do
  
  let(:warmup) { Warmup.new }

  describe "#gets_shout" do
    it "returns input in all caps" do
      allow(warmup).to receive(:gets).and_return("hello, world.")
      allow(warmup).to receive(:puts).and_return(nil)
      expect(warmup.gets_shout).to eq("HELLO, WORLD.")
    end
  end

  describe "#triple_size" do
    it "returns three times the size of the array" do
      array = double(size: 4)

      expect(warmup.triple_size(array)).to eq(12)
    end
  end

  describe "#calls_some_methods" do
    let(:string) { double(empty?: false, upcase!: "HELLO", reverse!: "OLLEH") }

    it "the string receieves the #upcase method" do
      expect(string).to receive(:upcase!)
      warmup.calls_some_methods(string)
    end

    it "the string receieves the #reverse method" do
      expect(string).to receive(:reverse!)
      warmup.calls_some_methods(string)
    end

    it "returns a completely different object" do
      expect(warmup.calls_some_methods(string)).to_not eq(string)
    end
  end
end