require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

before do
  @user_details = YAML.load_file("users.yaml")
  @users = @user_details.map { |name_array, _| name_array }
end

helpers do
  def count_interests
    num_of_interests = []
    @user_details.each_pair do |_, details|
      details.each_pair do |key, value|
        num_of_interests << value if key == :interests
      end
    end
    num_of_interests.flatten.size
  end
end

get "/" do
  @users

  erb :home
end

get "/person/:name" do
  name = params[:name].to_sym
  @email = @user_details[name][:email]
  @interests = @user_details[name][:interests]
  @others = @users - [name]

  erb :person

end