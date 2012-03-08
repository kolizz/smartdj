class PartyArtistsController < ApplicationController
  # GET /party_artists
  # GET /party_artists.json
  def index
    @party_artists = PartyArtist.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @party_artists }
    end
  end

  # GET /party_artists/1
  # GET /party_artists/1.json
  def show
    @party_artist = PartyArtist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @party_artist }
    end
  end

  # GET /party_artists/new
  # GET /party_artists/new.json
  def new
    @party_artist = PartyArtist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @party_artist }
    end
  end

  # GET /party_artists/1/edit
  def edit
    @party_artist = PartyArtist.find(params[:id])
  end

  # POST /party_artists
  # POST /party_artists.json
  def create
    @party_artist = PartyArtist.new(params[:party_artist])

    respond_to do |format|
      if @party_artist.save
        format.html { redirect_to @party_artist, notice: 'Party artist was successfully created.' }
        format.json { render json: @party_artist, status: :created, location: @party_artist }
      else
        format.html { render action: "new" }
        format.json { render json: @party_artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /party_artists/1
  # PUT /party_artists/1.json
  def update
    @party_artist = PartyArtist.find(params[:id])

    respond_to do |format|
      if @party_artist.update_attributes(params[:party_artist])
        format.html { redirect_to @party_artist, notice: 'Party artist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @party_artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /party_artists/1
  # DELETE /party_artists/1.json
  def destroy
    @party_artist = PartyArtist.find(params[:id])
    @party_artist.destroy

    respond_to do |format|
      format.html { redirect_to party_artists_url }
      format.json { head :no_content }
    end
  end
end
