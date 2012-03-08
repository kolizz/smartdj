class User < ActiveRecord::Base
  has_many :users

  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
end
