require 'net/http'

class PartyTracksController < ApplicationController
  # GET /party_tracks
  # GET /party_tracks.json
  def index
    # FIXME: Scope on party_id
    @party_tracks = PartyTrack.all

    top_artists = PartyArtist.where(['count > 3']).order('count DESC').limit(20)
    artist = top_artists[rand(top_artists.count)]

    url = URI.parse("https://ws.spotify.com/search/1/track.json?q=artist:#{artist.name}")
    puts "the url: #{url.to_s}"
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    puts "the res body: #{res.body}"

    response_hash = res.body.from_json
    tracks = response_hash['tracks']
    puts "tracks: #{tracks}"
    random_track = tracks[rand(tracks.count)]
    puts "random_track: #{random_track}"
    track_url = random_track['href']
    puts "the track_url: #{track_url}"

    respond_to do |format|
      format.html # index.html.erb
      format.json do
        hash = {
          'url' => track_url
        }
        render json: hash.to_json
      end
    end
  end

  # GET /party_tracks/1
  # GET /party_tracks/1.json
  def show
    @party_track = PartyTrack.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @party_track }
    end
  end

  # GET /party_tracks/new
  # GET /party_tracks/new.json
  def new
    @party_track = PartyTrack.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @party_track }
    end
  end

  # GET /party_tracks/1/edit
  def edit
    @party_track = PartyTrack.find(params[:id])
  end

  # POST /party_tracks
  # POST /party_tracks.json
  def create
    @party_track = PartyTrack.new(params[:party_track])

    respond_to do |format|
      if @party_track.save
        format.html { redirect_to @party_track, notice: 'Party track was successfully created.' }
        format.json { render json: @party_track, status: :created, location: @party_track }
      else
        format.html { render action: "new" }
        format.json { render json: @party_track.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /party_tracks/1
  # PUT /party_tracks/1.json
  def update
    @party_track = PartyTrack.find(params[:id])

    respond_to do |format|
      if @party_track.update_attributes(params[:party_track])
        format.html { redirect_to @party_track, notice: 'Party track was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @party_track.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /party_tracks/1
  # DELETE /party_tracks/1.json
  def destroy
    @party_track = PartyTrack.find(params[:id])
    @party_track.destroy

    respond_to do |format|
      format.html { redirect_to party_tracks_url }
      format.json { head :no_content }
    end
  end
end
