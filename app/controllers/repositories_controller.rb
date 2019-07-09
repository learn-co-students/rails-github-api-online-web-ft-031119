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

  def create
    response = Faraday.post("https://api.github.com/user/repos", {name: params[:name]}.to_json, {
      'Accept' => 'application/json',
      'Authorization' => "token #{session[:token]}"
    })

    redirect_to root_path
  end

end
