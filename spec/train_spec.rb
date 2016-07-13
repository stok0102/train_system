require("spec_helper")

describe(Train) do
  describe("#name") do
    it("returns a name") do
      test_train = Train.new({:name => "Orient Express"})
      expect(test_train.name()).to eq("Orient Express")
    end
  end

end
