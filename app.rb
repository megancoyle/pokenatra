require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'active_record'

require_relative 'db/connection'
require_relative 'models/pokemon'
require_relative 'models/trainer'
require_relative 'models/team'

get '/' do
  erb :index
end

get '/teams' do
  @teams = Team.all
  erb :"teams/index"
end

get '/teams/new' do
  erb :"teams/new"
end

get '/teams/:id' do
  @team = Team.find(params[:id])
  @trainers = Team.find(params[:id]).trainers.pluck(:name)
  erb :"teams/show"
end

post '/teams' do
  @team = Team.create(params[:team])
  redirect "/teams/#{@team.id}"
end

get '/teams/:id/edit' do
  @team = Team.find(params[:id])
  erb :"teams/edit"
end

put '/teams/:id' do
  team = Team.find(params[:id])
  team.update(params[:team])
  redirect "/teams/#{team.id}"
end

delete '/teams/:id' do
  team = Team.find(params[:id])
  team.destroy
  redirect '/teams'
end

get '/trainers' do
  @trainers = Trainer.all
  erb :"trainers/index"
end

get '/trainers/new' do
  @teams = Team.all
  erb :"trainers/new"
end

get '/trainers/:id' do
  @trainer = Trainer.find(params[:id])
  @pokemons = Trainer.find(params[:id]).pokemons.pluck(:name)
  @team = Team.find(@trainer.team_id)
  erb :"trainers/show"
end

post '/trainers' do
  @trainer = Trainer.create(params[:trainer])
  redirect "/trainers/#{@trainer.id}"
end

get '/trainers/:id/edit' do
  @trainer = Trainer.find(params[:id])
  @teams = Team.all
  erb :"trainers/edit"
end

put '/trainers/:id' do
  trainer = Trainer.find(params[:id])
  trainer.update(params[:trainer])
  redirect "/trainers/#{trainer.id}"
end

delete '/trainers/:id' do
  trainer = Trainer.find(params[:id])
  trainer.destroy
  redirect '/trainers'
end

get '/pokemons' do
  @pokemons = Pokemon.all
  erb :"pokemons/index"
end

get '/pokemons/new' do
  erb :"pokemons/new"
end

get '/pokemons/:id' do
  @pokemon = Pokemon.find(params[:id])
  erb :"pokemons/show"
end

post '/pokemons' do
  @pokemon = Pokemon.create(params[:pokemon])
  redirect "/pokemons/#{@pokemon.id}"
end

get '/pokemons/:id/edit' do
  @pokemon = Pokemon.find(params[:id])
  erb :"pokemons/edit"
end

put '/pokemons/:id' do
  pokemon = Pokemon.find(params[:id])
  pokemon.update(params[:pokemon])
  redirect "/pokemons/#{pokemon.id}"
end

delete '/pokemons/:id' do
  pokemon = Pokemon.find(params[:id])
  pokemon.delete
  redirect '/pokemons'
end
