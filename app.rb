require 'sinatra'
require "sinatra/reloader"


# Run this script with `bundle exec ruby app.rb`

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
if ENV['DATABASE_URL']
  require 'pg'
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else 
  require 'sqlite3'
  ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.db'
)
end
register Sinatra::Reloader
enable :sessions


get '/' do
  erb :landing
end

get '/signup' do
  erb :sign_up
end

post '/user/signup' do
  new_user = User.create(first_name: params['first_name'] , last_name:params['last_name'], display_name:params['display_name'], email:params['email'], gender:params['gender'], password:params['password'])
  session[:user_id] = new_user.id
  redirect '/'
end

get '/login' do
  erb :logins
end

post 'login' do
  user= User.find_by(email: params['email'], password: params['password'])
  if user
    puts user
    session[ :user_id] =user.id
    #redirect to blog
  else
    redirect '/allowed'
  end
end

get '/allowed' do
  @post=Post.all
  erb :main_page
end

post '/allowed' do
  user= User.find_by(email: params['email'], password: params['password'])
  if user
    puts user
    session[ :user_id] =user.id
  else
    redirect '/profile'
  end
end

 get '/profile' do
  @user=User.find(session[:user_id])
  erb :profile
end

get '/hub' do
  @users= User.all 
  @posts= Post.all
  erb :hub
end



get '/share' do
  erb :create_post
end

post '/share' do
  new_post= Post.create(title: params['title'] , content: params['content'], user_id: session[:user_id])
  redirect '/hub'
end
