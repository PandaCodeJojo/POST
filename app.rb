require 'sinatra'
require "sinatra/reloader"


# Run this script with `bundle exec ruby app.rb`
require 'sqlite3'
require 'active_record'

#require model classes
# require './models/cake.rb'
require './models/user.rb'
require './models/post.rb'


# Use `binding.pry` anywhere in this script for easy debugging
require 'pry'
require 'csv'

# Connect to a sqlite3 database
# If you feel like you need to reset it, simply delete the file sqlite makes
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.db'
)

register Sinatra::Reloader
enable :sessions

get '/' do
  erb :index
end

get '/signup' do
  erb :sign_up
end

post '/user/signup' do
  new_user = User.create(first_name: params['first_name'] , last_name:params['last_name'], display_name:params['display_name'], email:params['email'], gender:params['gender'], password:params['password'])
  redirect '/'

end

get '/login' do
  erb :login
end
