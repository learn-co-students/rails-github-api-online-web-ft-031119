class RepositoriesController < ApplicationController
  
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
      req.headers["Accept"] = 'application/json'
    end
    @repos_array = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.params["name"] = params[:name]
      req.headers["Authorization"] = `token #{session[:token]}`
      req.headers["Accept"] = 'application/json'
      redirect_to root_path
    end
  end

end
