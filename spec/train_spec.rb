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

  describe("#==") do
    it "is the same train if it has the same name" do
      train1 = Train.new({:name => "Orient Express", :id => 1})
      train2 = Train.new({:name => "Orient Express", :id => 2})
      expect(train1).to(eq(train2))
    end
  end

  describe(".find") do
    it "returns a train by its ID" do
      test_train = Train.new({:name => "Orient Express", :id => nil})
      test_train.save()
      test_train2 = Train.new({:name => "Trans Siberian Railcar", :id => nil})
      test_train2.save()
      expect(Train.find(test_train2.id())).to(eq(test_train2))
    end
  end

  describe("#delete") do
    it "lets you delete a train from the database" do
      train = Train.new({:name => "Orient Express", :id => nil})
      train.save()
      train2 = Train.new({:name => "Trans Siberian Railcar", :id => nil})
      train2.save()
      train.delete()
      expect(Train.all()).to(eq([train2]))
    end
  end

  describe("#update") do
    it "lets you update trains in the database" do
      train = Train.new({:name => "Hyperloop", :id => nil})
      train.save()
      train.update({:name => "Rockport Limited"})
      expect(train.name()).to(eq("Rockport Limited"))
    end
  end
end
