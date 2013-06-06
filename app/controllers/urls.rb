 use Rack::Session::Pool

 get '/' do
  puts session.inspect
  erb :index
end

post '/urls' do
  bacon = params[:bacon].gsub(/ /, '').gsub(/\./, '').gsub(/\-/, '')[0..15]
  url = params[:url]
  url = 'http://' + url if url !~ /http/

  if session[:logged_in_user_id] == nil
    puts "not logged in"
    puts session.inspect
    puts session[:logged_in_user_id]
    Url.create(url: url, baconurl: bacon)
  else
    puts "logged in"
    Url.create(url: url, baconurl: bacon, user_id: session[:logged_in_user_id])
  end  
  "<a href='http://localhost:9393/#{bacon}'>http://localhost:9393/#{bacon}</a>"
end

# e.g., /q6bda
get '/:short_url' do
  url_code = Url.where(:baconurl => params[:short_url])[0]
  url_code.click_counter += 1
  url_code.save
  redirect "#{url_code.url}"
end
# 7e2965aac5865b8d3749fd0d1d1a13fded284583a3efea0360443950602f424b
