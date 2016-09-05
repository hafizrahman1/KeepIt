class UsersController < ApplicationController

  get '/signup' do
  	if logged_in?
      redirect "/users/:id"
  	else
  	  erb :'users/create_user'
  	end
  end

  # Create a new user
  post '/signup' do
  	if params[:username] == "" || params[:password] == ""
  	  redirect to '/signup'
  	else
  	  @user = User.create(username: params[:username], password: params[:password])
  	  session[:user_id] = @user.id
      flash[:message] = "Welcome to your dashboard, #{current_user.username}!"
  	  redirect "/users/#{@user.id}"
  	end
  end

  get '/login' do
  	if logged_in?
  	  erb :"/users/show"
  	else
  	  erb :"users/login"
  	end
  end

  post '/login' do
  	@user = User.find_by(username: params[:username])

  	if @user && @user.authenticate(params[:password])
  	  session[:user_id] = @user.id
      flash[:message] = "Welcome back, #{@user.username}"
  	  redirect "/users/#{current_user.id}"
  	else
      flash[:message] = "Wrong username and password... Please try again, or signup first."
  	  redirect'/login'
  	end
  end

  # display user profile page
  get '/users/:id' do
    @user = User.find_by(id: params[:id])
    if logged_in?
      erb :"/users/show" 
    else
      # flash[:notice] = "Oops... Try that again, please."
      redirect '/login'
    end
  end

  get '/logout' do
  	if session[:user_id] != nil
  	  session.destroy
  	  redirect to '/'
  	else
  	  redirect to '/'
  	end
  end

end