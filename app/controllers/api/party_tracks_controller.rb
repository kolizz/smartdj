require 'net/http'

class Api::PartyTracksController < ApplicationController
  # GET /party_tracks
  # GET /party_tracks.json
  def index
    #@party_tracks = PartyTrack.find_all_by_party_id params[:party_id]

    top_artists = PartyArtist.where(['count >= 1']).where(party_id: params[:party_id]).order('count DESC').limit(100)

	  if top_artists.count == 0
		  render nothing: true, status: 404
		  return
	  end

	  random_track = find_track(top_artists)
	  track_url = random_track['href']

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

  private

  def find_track(top_artists)
	  artist = top_artists[rand(top_artists.count)]

	  response = Net::HTTP.get_response(URI.parse("http://ws.spotify.com/search/1/track.json?q=artist:#{CGI::escape(artist.name)}") )
	  puts "response.body: #{response.body}"

	  response_hash = JSON.parse(response.body.to_s)
	  tracks = response_hash['tracks']
	  puts "tracks: #{tracks}"
	  if (tracks.present?)
		  return tracks[rand(tracks.count)]
	  else
		  return find_track(top_artists)
	  end
  end
end
