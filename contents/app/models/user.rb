class User < ActiveRecord::Base
  # Include all devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable, :lockable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
                  
  # attach profile
  has_one :profile
  has_many :pictures
  has_many :albums
  
  # automatically create (empty) profile
  after_create :create_empty_profile
  
  def create_empty_profile
     Profile.create(:user_id => self.id)
  end
end
