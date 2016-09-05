require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  	set :session_secret, "notes_secret"
  end

 # home page
  get '/' do
  	erb :index
  end

  # helper methods
  helpers do

  # current user
 	def current_user
 	  @_current_user ||= User.find_by(id: session[:user_id])
 	end
  
  # logged_in or not?
 	def logged_in?
 	  !!session[:user_id]
 	end

  end

end