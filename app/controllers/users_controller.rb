class UsersController < ApplicationController
 get '/signup' do
  if !logged_in?
    erb :'/users/signup'
  else
    redirect to '/tweets'
   end
  end
  
 
  post '/signup' do
    #binding.pry
    if params["username"] != "" && params["email"] != "" && params["password"] != ""
      @user = User.create(username: params["username"], email: params["email"], password: params["password"])
      @session = session
      @session[:id] = @user[:id]
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end
  

  
  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else 
      erb :'/users/login'
    end
  end
  
  
  post '/login' do
    binding.pry
    @user = User.find_by(username: params["user"]["username"])
    if @user && @user.authenticate(params["user"]["password"])
      session[:id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end
  
  
  get '/logout' do
    if logged_in?
       session.destroy
       redirect to '/login'
     else
      redirect to '/login'
     end
  end
  
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end
  
  
  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end
end
