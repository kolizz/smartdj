class PartyArtist < ActiveRecord::Base
  belongs_to :user

  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
end
