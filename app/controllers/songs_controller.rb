class SongsController < ApplicationController

  # use Rack::Flash




  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    @artists = Artist.all
    @genres = Genre.all
    erb :'/songs/new'
  end

  get "/songs/:slug" do
    @song = Song.find_by_slug(params[:slug])

    erb :'/songs/show'
  end

  post '/songs' do

    @song = Song.find_or_create_by(:name => params['name'] )

    if params['artist_name'].empty?
      @song.artist = Artist.find_by_id(params[:artist_id])
    else
      @song.artist = Artist.find_or_create_by(:name => params['artist_name'])
    end

    if params['genre_name'] != ""
      genre = Genre.find_or_create_by(:name =>  params['genre_name'])

      @song.genres << genre
    end

    if params['genres']

      params['genres'].each do |g|
        genre = Genre.find_or_create_by(:id => g)

        @song.genres << genre
      end

    end



    @song.save







    # erb :"/songs/#{@song.slug}"

    redirect("/songs/#{@song.slug}")
  end

  get '/songs/:slug/edit' do

    @song = Song.find_by_slug(params[:slug])

    @genres = @song.genres

    erb :'/songs/edit'
  end

  patch '/songs/:slug' do




    @song = Song.find_by_id(params['song_id'])

    @song.artist = Artist.find_or_create_by(:name => params["artist_name"])


    # @song.genre_ids = params['genres']
    params['genres'].each do |g|
      genre = Genre.find_or_create_by(:id => g)

      @song.genres << genre
    end

    @song.save






    redirect("/songs/#{@song.slug}")






  end

end
