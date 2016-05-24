require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

before do
  @user_details = YAML.load_file("users.yaml")
  @users = @user_details.map { |name_array, _| name_array }
end

get "/" do
  @users

  erb :home
end

get "/person/:name" do
  name = params[:name]
  @email = @user_details[name.to_sym][:email]
  @interests = @user_details[name.to_sym][:interests]
  @others = @users - [name.to_sym]

  erb :person

end