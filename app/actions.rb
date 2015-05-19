# Homepage (Root path)
helpers do
	def post_user(arg)
		return User.find(arg).username if arg.is_a?(Integer)
    User.find(arg.user_id).username
  end

  def ass_votes
  	Song.all.each do |song| 
  		song.vote_count = total_votes(song.id) 
  		song.save
  	end
  end

  def sort_desc_by_votes
    ass_votes
    Song.order(vote_count: :desc)
  end

  def total_votes(song_id)
  	puts "song id"
  	Vote.where(song_id: song_id).sum("vote")
  end


  	# if !!Vote.find_by(user_id: user_id) && 
  		 # !!Vote.find_by(song_id: song_id)
  def current_user_voted?(song)
    !!Vote.find_by(song_id: song.id) &&
       Vote.find_by(user_id: session[:id])
  end

  def session?
  	!!session[:id]
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

get '/song/:id' do
  @song = Song.find(params[:id])
  erb :'song/id'
end

post 
# get '/messages/:id' do
# 	@message = Message.find params[:id]
# 	erb :'messages/show'
# end
