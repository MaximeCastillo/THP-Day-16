require 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new' do
    erb :new_gossip
  end

  post '/gossips/new' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id' do
    erb :show, locals: {id: (params["id"].to_i-1), gossip: Gossip.find(params["id"].to_i-1)}
  end

  get '/gossips/:id/edit' do
    erb :edit, locals: {id: (params["id"].to_i-1), gossip: Gossip.find(params["id"].to_i-1)}
  end

  post '/gossips/:id/edit' do
    Gossip.update(params["id"].to_i-1, params["gossip_editor"], params["gossip_edited_content"])
    redirect "/gossips/#{params["id"]}/edit"
  end
end
