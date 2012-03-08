class PartyTrack < ActiveRecord::Base
  belongs_to :party
  belongs_to :party_artist

  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
end
