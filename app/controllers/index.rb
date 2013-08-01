get '/' do
  # Look in app/views/index.erb

  erb :index
end

post '/create' do

  @user = User.create(params[:user])

  session[:user_id] = @user.id

  redirect to '/secret_page'

end

get '/secret_page' do
  if session[:user_id]
    @user = User.find(session[:user_id])
     erb :secret_page
  else
    redirect to '/'
  end
  
end

get '/logout' do
  session[:user_id] = nil
  redirect to '/'
end

post '/login' do
  @user = User.authenticate(params[:email], params[:password])
  session[:user_id] = @user.id

  redirect '/secret_page'
end
