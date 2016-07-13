require("spec_helper")

describe(Train) do
  describe("#name") do
    it("returns a name") do
      test_train = Train.new({:name => "Orient Express"})
      expect(test_train.name()).to eq("Orient Express")
    end
  end

  describe(".all") do
    it "empty at first" do
      expect(Train.all()).to(eq([]))
    end
  end

  describe("#save") do
    it "lets you save trains to the database" do
      train = Train.new({:name => "Orient Express", :id => nil})
      train.save()
      expect(Train.all()).to(eq([train]))
    end
  end
end
