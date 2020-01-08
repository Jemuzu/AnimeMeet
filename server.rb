require 'sinatra'
require 'sinatra/activerecord'
# require 'rake'
require 'pg'
require './models'

set :database, {
  adapter: 'postgresql',
  database: 'users-blog',
  username: 'postgres',
  password: ENV['POSTGRES_PW']}
  enable :sessions

set :port, 1357
#set :database, {adapter: ""}
#enable :sessions

get '/' do
  erb :home
end

get '/login' do
  erb :login
end

post '/login' do
  user = User.find_by(email: params[:email])
  given_password = params[:password]
    if user.password == given_password
      session[:user_email] = user.id
      session[:user_password] = user.password
      session[:user_first] = user.first
      session[:user_last] = user.last
      session[:user_bio] = user.bio
      session[:user_birthday] = user.birthday
      redirect '/profile'
  else
    flash[:error] = 'Correct email, but wrong password. Did you mean: #{user.password}? \Only use this password if it is your account.'
    redirect '/login'
  end
end

post '/signup' do
    @user = User.new(params[:user])
    if @user.valid?
      @user.save
      redirect '/profile'
    else
      flash[:error] = @users.errors.full_messages
      redirect '/signup'
    end
end

get '/profile' do
  erb :profile
end

get '/signout' do
  erb :signout
  session.clear
  redirect '/'
end

get '/anime' do
  erb :anime
end

get '/signup' do
  erb :signup
end
