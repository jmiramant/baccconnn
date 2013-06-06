use Rack::Session::Pool

post '/create' do
  User.create(params)
  authenticated_user = User.where(:email => params[:email])
  session[:logged_in_user_id] = authenticated_user[0].id
  redirect '/secret' 
end 

get '/users/new' do
  erb :users_new
end
