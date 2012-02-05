# encoding: utf-8
#
# rshot (http://rshot.net) - a social digital photo gallery.
# (c) 2011-2012 Raphael Kallensee
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  # relationships
  belongs_to :commentable, :polymorphic => true
  belongs_to :profile

  default_scope :order => 'created_at ASC'

  # attribute protection
  attr_accessible :comment

  # validators
  validates :comment, :presence => true, :length => { :minimum => 3, :maximum => 2000 }
  validates_presence_of :profile_id

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable
end
