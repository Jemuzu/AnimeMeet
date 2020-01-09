require 'sinatra'
require 'sinatra/activerecord'
require 'rake'
require 'pg'
require './models'

set :database, {
  url: ENV['DATABASE_URL']}
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

post '/signup' do
  user = User.find_by(email: params[:email])
  given_password = params[:password]
    if user.password == given_password
      session[:user_email] = user.id
      session[:user_password] = user.password
      session[:user_firstname] = user.first
      session[:user_lastname] = user.last
      session[:user_biography] = user.bio
      session[:user_birt] = user.birthday
      redirect '/profile'
  else
    flash[:error] = 'Correct email, but wrong password. Did you mean: #{user.password}? \Only use this password if it is your account.'
    redirect '/login'
  end
end

post '/login' do
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

get '/users' do
  @users = User.all
  erb :index
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :show
end

post '/' do
    @post = Post.new(title: params[:title], content: params[:content], time_posted: Time.now, user_id: session[:user_id])
    if @post.valid?
        pp @post
        @post.save
        redirect '/'
    else
        flash[:errors] = @post.errors.full_messages
        redirect '/'
    end
end
