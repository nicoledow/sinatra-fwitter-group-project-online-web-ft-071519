class TweetsController < ApplicationController

 get '/tweets' do
   if logged_in?
    @current_user = current_user 
    @tweets = Tweet.all
    erb :'/tweets/tweet_index'
   else
     redirect to '/login'
   end
 end
 
 
 get '/tweets/new' do
   binding.pry
  @current_user = current_user
   if !!session[:id]
     erb :'tweets/create_tweet'
   else
     redirect to '/login'
   end
 end
 
 
 post '/tweets' do
  if params["content"] != "" 
    @new_tweet = current_user.tweets.build(content: params["content"])
    @new_tweet.save
    redirect to '/tweets'
  else
    redirect to 'tweets/new'
  end
end

 
 
 get '/tweets/:id' do
   @tweet = Tweet.find_by_id(params["id"])
   @author = User.find_by_id(@tweet.user_id)
   erb :'/tweets/show_tweet'
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

