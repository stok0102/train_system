require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/train")
require("./lib/city")
require('pg')
require('pry')

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
  erb(:success)
end

delete("/train") do
  @train = Train.find(params.fetch("train_id").to_i())
  @train.delete()
  @trains = Train.all()
  erb(:success)
end

post("/cities") do
  name = params.fetch("city_name")
  city = City.new({:name => name, :id => nil})
  city.save()
  erb(:success)
end

delete("/city") do
  @city = City.find(params.fetch("city_id").to_i())
  @city.delete()
  @cities = City.all()
  erb(:success)
end

get("/trains/:id") do
  @train = Train.find(params.fetch("id").to_i())
  @cities = City.all()
  erb(:train_info)
end

get("/cities/:id") do
  @city = City.find(params.fetch("id").to_i())
  @trains = Train.all()
  erb(:city_info)
end

patch("/trains/:id") do
  train_id = params.fetch("id").to_i()
  @train = Train.find(train_id)
  city_ids = params.fetch("city_ids", [])
  time = params.fetch("time")
  @train.update({:city_ids => city_ids, :time => time})
  @cities = City.all()
  erb(:train_info)
end

patch("/cities/:id") do
  city_id = params.fetch("id").to_i()
  @city = City.find(city_id)
  train_ids = params.fetch("train_ids", [])
  @city.update({:train_ids => train_ids})
  @trains = Train.all()
  erb(:city_info)
end
