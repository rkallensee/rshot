class Album < ActiveRecord::Base
  has_many :pictures, :dependent => :nullify
  belongs_to :profile
end
