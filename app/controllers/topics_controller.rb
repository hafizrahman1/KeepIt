class TopicsController < ApplicationController

  # topics show route
  get '/topics/:id' do
  	@topic = Topic.find_by_id(params[:id])
    erb :"topics/show" 
  end
end