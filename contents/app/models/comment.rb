class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true
  belongs_to :profile

  default_scope :order => 'created_at ASC'

  validates :comment, :presence => true, :length => { :minimum => 3 }
  validates_presence_of :profile_id

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable
end
