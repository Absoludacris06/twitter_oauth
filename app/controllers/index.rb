get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  session.delete(:request_token)

  if User.find_by_username(@access_token.params[:screen_name]) == nil
    @user = User.new(username: @access_token.params[:screen_name], oauth_token: @access_token.token, oauth_secret: @access_token.secret)
    if @user.save
      session[:user_id] = @user.id
      erb :index
    else
      redirect to('/')
    end
  else
    session[:user_id] = User.find_by_username(@access_token.params[:screen_name]).id
  end
  
end
