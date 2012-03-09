class User < ActiveRecord::Base
  has_many :users

  validates_uniqueness_of :fb_uid, :on => :create, :message => "must be unique"
end
