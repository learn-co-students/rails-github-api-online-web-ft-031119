class RepositoriesController < ApplicationController
  
  def index
    user = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end

    body = JSON.parse(user.body)
    session[:username] = body['login']

    repos_response = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @repos_array = JSON.parse(repos_response.body)
  end

end
