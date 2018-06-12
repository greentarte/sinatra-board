gem 'json', '~> 1.6'
require "sinatra"
require "sinatra/reloader"
require ".model.rb"

before do
    p '----------------------------------'
    p params
    p '----------------------------------'
end

get '/' do
    send_file 'main.html'
end

get '/login' do
    erb :'user/login'
end

get '/join' do
    erb :'user/join'
end
