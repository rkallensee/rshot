class Album < ActiveRecord::Base
  has_many :pictures, :dependent => :nullify
end
