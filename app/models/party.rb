class Party < ActiveRecord::Base
  has_many :users
  has_many :party_artists
  has_many :party_tracks
end
