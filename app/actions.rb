# Homepage (Root path)
get '/' do
	@songs = Song.all
  erb :index
end

post '/' do
		@song = Song.new(
		         song_title: params[:song_title],
		         user_id: params[:user_id],
		         url: params[:url] || ""
		            )
	if @song.save
		redirect '/'
	else
		erb :index
	end
end

# get '/messages/:id' do
# 	@message = Message.find params[:id]
# 	erb :'messages/show'
# end
