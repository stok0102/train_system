require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/train")
require("./lib/city")
require('pg')

DB = PG.connect({:dbname => 'train_system_test'})

get("/") do
  @trains = Train.all()
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
