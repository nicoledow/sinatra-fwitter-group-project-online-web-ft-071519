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
  @current_user = current_user
   if logged_in?
     erb :'tweets/create_tweet'
   else
     redirect to '/login'
   end
 end
 
 
 get '/tweets/:id' do
   @tweet = Tweet.find_by_id(params["id"])
   @author = User.find_by_id(@tweet.user_id)
   erb :'/tweets/show_tweet'
 end


post '/tweets' do
  @new_tweet = current_user.tweets.build(content: params["content"])
  @new_tweet.save
  redirect to '/tweets'
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

