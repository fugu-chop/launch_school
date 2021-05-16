require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require 'yaml'

helpers do
  def count_interests
    @users.values.reduce(0) do |interests, hash|
      interests += hash[:interests].size
    end
  end
end

before do
  @users = YAML.load_file('users.yaml')
  @total_users = @users.keys.size
  @total_interests = @users.values
end

get "/" do
  @title = "User Directory"
  erb(:home)
end

get "/:user" do
  redirect "/" unless @users.keys.include?(params[:user])
  @title = params[:user]
  @email = @users[@title.to_sym][:email]
  @interests = @users[@title.to_sym][:interests]
  erb(:user)
end
