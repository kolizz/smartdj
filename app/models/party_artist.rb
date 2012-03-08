class PartyArtist < ActiveRecord::Base
  belongs_to :party

  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
end
