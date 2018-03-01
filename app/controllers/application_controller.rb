require './config/environment'

class ApplicationController < Sinatra::Base

  get '/' do
    @posts = Post.all
    erb(:'/posts/index')
  end

end
