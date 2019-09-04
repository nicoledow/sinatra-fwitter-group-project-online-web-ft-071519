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
   #binding.pry
   if logged_in?
     @tweet = Tweet.find_by_id(params["id"])
     @author = User.find_by_id(@tweet.user_id)
     erb :'/tweets/show_tweet'
   else
     redirect to '/login'
   end
 end
 
 
 get '/tweets/:id/edit' do
   @tweet = Tweet.find_by_id(params["id"])
   
   if @tweet.user_id == session[:id]
     erb :'/tweets/edit_tweet'
   else
     redirect to '/tweets'
    end
 end
 
 
# patch '/tweets/:id' do
#   binding.pry
#     if logged_in?
#       if params["content"] == ""
#         redirect to "/tweets/#{params[:id]}/edit"
#       else
#         @tweet = Tweet.find_by_id(params[:id])
#         if @tweet && @tweet.user == current_user
#           if @tweet.update(content: params["content"])
#             redirect to "/tweets/#{@tweet.id}"
#           else
#             redirect to "/tweets/#{@tweet.id}/edit"
#           end
#         else
#           redirect to '/tweets'
#         end
#       end
#     else
#       redirect to '/login'
#     end
#   end
 
 
patch '/tweets/:id' do
  binding.pry
  @tweet = Tweet.find_by_id(params["id"])
  
  if logged_in? && @tweet.user_id == session[:id]
  @tweet.update(content: params["content"])
  redirect to '/tweets'
end
 
 
 delete '/tweets/:id/delete' do
   Tweet.find_by_id(params["id"]).destroy
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

