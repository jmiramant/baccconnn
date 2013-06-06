use Rack::Session::Pool
require 'sinatra/flash'

get '/login' do
  erb :login
end

post '/login' do
  @user = User.find_by_email(params[:email])
  if @user && @user.password == params[:password_hash] 
    session[:logged_in_user_id] = @user.id
    @baconated_urls = @user.urls
    erb :user_view
  else
    flash[:bad_login] = "No soup for you!"
    redirect "/"
  end
end

get '/logout' do
  puts session.inspect
  session.clear
  puts session.inspect
  erb :bye
end


get '/users' do
  if session[:logged_in_user_id] == nil
    flash[:bad_login] = "No soup for you!"
    redirect '/'
  else
    user = User.find(session[:logged_in_user_id])
    @baconated_urls = user.urls
    erb :user_view
  end
end

