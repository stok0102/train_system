require("spec_helper")

describe(Train) do
  describe("#name") do
    it("returns a name") do
      test_train = Train.new({:name => "Orient Express"})
      expect(test_train.name()).to eq("Orient Express")
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      train = Train.new({:name => "Hyperloop", :id => nil})
      train.save()
      expect(train.id()).to(be_an_instance_of(Fixnum))
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
    
    it "lets you add a city to a train" do
      train = Train.new({:name => "Trans Siberian Railcar", :id => nil})
      train.save()
      zurich = City.new({:name => "zurich", :id => nil})
      zurich.save()
      detroit = City.new({:name => "detroit", :id => nil})
      detroit.save()
      train.update({:city_ids => [zurich.id(), detroit.id()]})
      expect(train.cities()).to(eq([zurich, detroit]))
    end
  end

  describe("#cities") do
    it "returns all of the cities a train stops at" do
      train = Train.new({:name => "Trans Siberian Railcar", :id => nil})
      train.save()
      zurich = City.new({:name => "zurich", :id => nil})
      zurich.save()
      detroit = City.new({:name => "detroit", :id => nil})
      detroit.save()
      train.update({:city_ids => [zurich.id(), detroit.id()]})
      expect(train.cities()).to(eq([zurich, detroit]))
    end
  end
end
