class RepositoriesController < ApplicationController

  def index
    response = Faraday.get "https://api.github.com/user/repos" do |conn|
      conn.params['access_token'] = "#{session[:token]}"
    end
    @repos = JSON.parse(response.body)
  end

  def create
    response = Faraday.post "https://api.github.com/user/repos" do |conn|
      conn.params['access_token'] = "#{session[:token]}"
      conn.params["name"] = params[:name]
      redirect_to '/'
    end
  end

end
