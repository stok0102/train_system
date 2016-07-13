require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/train")
require("./lib/city")
require('pg')

DB = PG.connect({:dbname => 'train_system_test'})

get("/") do
  @trains = Train.all()
  @cities = City.all()
  erb(:index)
end

post("/trains") do
  name = params.fetch("train_name")
  train = Train.new({:name => name, :id => nil})
  train.save()
  @trains = Train.all()
  @cities = City.all()
  erb(:index)
end

delete("/train/:id") do
  @train = Train.find(params.fetch("id").to_i())
  @train.delete()
  @trains = Train.all()
  @cities = City.all()
  erb(:index)
end

post("/cities") do
  name = params.fetch("city_name")
  city = City.new({:name => name, :id => nil})
  city.save()
  @trains = Train.all()
  @cities = City.all()
  erb(:index)
end

delete("/city/:id") do
  @city = City.find(params.fetch("id").to_i())
  @city.delete()
  @trains = Train.all()
  @cities = City.all()
  erb(:index)
end
