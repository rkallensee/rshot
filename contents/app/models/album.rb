class Album < ActiveRecord::Base
  has_many :pictures, :dependent => :nullify
  belongs_to :profile

  validates :title, :presence => true, :length => { :minimum => 3 }
  validates_presence_of :profile_id
end
