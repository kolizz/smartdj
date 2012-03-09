class PartiesController < ApplicationController
  # GET /parties
  # GET /parties.json
  def index
    @parties = Party.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: hash }
    end
  end

  # GET /parties/1
  # GET /parties/1.json
  def show
    @party = Party.find(params[:id])
    # @party = Party.find_or_create_by_name(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json do
        hash = {
          name: @party.name,
          url: "http://smartdj.herokuapp.com/party/#{@party.id}"
        }
        render json: hash
      end
    end
  end

  # GET /parties/new
  # GET /parties/new.json
  def new
    @party = Party.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @party }
    end
  end

  # GET /parties/1/edit
  def edit
    @party = Party.find(params[:id])
  end

  # POST /parties
  # POST /parties.json
  def create
    @party = Party.new(params[:party])

    # ta in parametrar skapa nytt party
    # POST /parties?name=MyParty

    # Respond with JSON containing
    # {
    #   "name" : "MyParty",
    #   "url" : "https://smartdj.herokuapp.com/party/4"
    # }

    respond_to do |format|
      if @party.save
        format.html { redirect_to @party, notice: 'Party was successfully created.' }
        format.json do
          # FULHACK!!
          hash = {
			id: @party.id,
            name: @party.name,
            url: "http://smartdj.local/parties/#{@party.id}"
          }
          render json: hash
        end
      else
        format.html { render action: "new" }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /parties/1
  # PUT /parties/1.json
  def update
    @party = Party.find(params[:id])

    respond_to do |format|
      if @party.update_attributes(params[:party])
        format.html { redirect_to @party, notice: 'Party was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parties/1
  # DELETE /parties/1.json
  def destroy
    @party = Party.find(params[:id])
    @party.destroy

    respond_to do |format|
      format.html { redirect_to parties_url }
      format.json { head :no_content }
    end
  end
end
