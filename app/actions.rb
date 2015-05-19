# Homepage (Root path)
helpers do
	def post_user(arg)
		return User.find(arg).username if arg.is_a?(Integer)
    User.find(arg.user_id).username
  end

  def sort_desc_by_votes
    #sorts the songs into an array of songs based on votes
  end

  def total_votes(id)
  	puts "song id"
  	puts id
  	Vote.where(song_id: id).sum("vote")
  end
end

get '/' do
	@songs = Song.all
  erb :index
end

post '/' do
		@song = Song.new(
						         song_title: params[:song_title],
						         user_id: session[:id],
						         url: params[:url] || ""
					         )
	if @song.save
		redirect '/'
	else
		erb :index
	end
end

get '/create' do
  erb :create
end

post '/create' do
	@password_match = (params[:password] == params[:password_confirm])
	@user = User.new(
		               username: params[:username],
		               password: params[:password]
		               )
	if @password_match && @user.save 
	#notify account creation
	  session[:id] = @user.id
		redirect '/'
	else
		erb :create
	end

end

get '/signin' do
	erb :signin
end

post '/signin' do
	user = User.find_by(username: params[:username])
	if user && user.password == params[:password]
		session[:id] = user.id
		puts session[:id].inspect
		@errors = nil
		redirect '/'
	else
		@errors = "Username or password is not correct"
		erb :signin
	end
end

get '/logout' do
	session[:id] = nil
	redirect '/'
end

get '/vote/:id' do
  vote = Vote.new(user_id: session[:id],
  	       song_id: params[:id],
  	       vote: 1
  	       )
  vote.save
  redirect '/'
end

# get '/messages/:id' do
# 	@message = Message.find params[:id]
# 	erb :'messages/show'
# end
