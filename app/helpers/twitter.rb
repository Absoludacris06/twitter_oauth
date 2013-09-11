def current_user
  if session[:user_id]
  	user = User.find(session[:user_id])
  	twitter_user = Twitter::Client.new(
  		:oauth_token => user.oauth_token,
  		:oauth_token_secret => user.oauth_secret
  	)
  	return twitter_user
  else
  	return nil
  end
end