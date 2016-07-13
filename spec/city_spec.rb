require("spec_helper")

describe(City) do
  describe("#name") do
    it("returns a name") do
      test_city = City.new({:name => "San Francisco"})
      expect(test_city.name()).to eq("San Francisco")
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      city = City.new({:name => "Oslo", :id => nil})
      city.save()
      expect(city.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe(".all") do
    it "empty at first" do
      expect(City.all()).to(eq([]))
    end
  end

  describe("#save") do
    it "lets you save cities to the database" do
      city = City.new({:name => "San Francisco", :id => nil})
      city.save()
      expect(City.all()).to(eq([city]))
    end
  end

  describe("#==") do
    it "is the same city if it has the same name" do
      city1 = City.new({:name => "San Francisco", :id => 1})
      city2 = City.new({:name => "San Francisco", :id => 2})
      expect(city1).to(eq(city2))
    end
  end

  describe(".find") do
    it "returns a city by its ID" do
      test_city = City.new({:name => "San Francisco", :id => nil})
      test_city.save()
      test_city2 = City.new({:name => "Hamburg", :id => nil})
      test_city2.save()
      expect(City.find(test_city2.id())).to(eq(test_city2))
    end
  end

  describe("#delete") do
    it "lets you delete a city from the database" do
      city = City.new({:name => "San Francisco", :id => nil})
      city.save()
      city2 = City.new({:name => "Hamburg", :id => nil})
      city2.save()
      city.delete()
      expect(City.all()).to(eq([city2]))
    end
  end

  describe("#update") do
    it "lets you update cities in the database" do
      city = City.new({:name => "Oslo", :id => nil})
      city.save()
      city.update({:name => "Grove City"})
      expect(city.name()).to(eq("Grove City"))
    end
  end
end
