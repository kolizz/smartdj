class PartyController < ApplicationController
  def index
    @party = Party.find(params[:party_id])
  end
end
