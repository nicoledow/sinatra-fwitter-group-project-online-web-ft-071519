
require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "1234567"
  end
  
  
  get '/' do
    erb :home
  end
  
  
 

end
