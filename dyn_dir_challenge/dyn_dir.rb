require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @files = Dir.entries("public").select {|f| !File.directory? f}.sort
  @files.reverse! if params[:sort] == "z-a"
  erb :home
end

