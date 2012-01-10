# encoding: utf-8
#
# rshot (http://rshot.net) - a social digital photo gallery.
# (c) 2011 Raphael Kallensee
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

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # important note from the CanCan wiki: "The block is only evaluated when an
    # actual instance object is present. It is not evaluated when checking
    # permissions on the class (such as in the index action). This means any
    # conditions which are not dependent on the object attributes should be
    # moved outside of the block."

    # every user can manage its own albums
    can :manage, Album do |album|
      album.try(:profile).try(:user) == user
    end

    # pictures may get created by registered users
    can :new, Picture, user.id > 0

    # pictures may only get edited or destroyed by their owners
    can [:edit, :destroy], Picture do |picture|
      picture.try(:profile).try(:user) == user
    end

    # pictures may get updated or created by their owner,
    # but may only get attached to users' own albums.
    can [:create, :update], Picture do |picture, params|
      unless picture.try(:profile).try(:user) == user
        false # skip if picture doesn't belong to user'
      else
        if picture.album.nil? && ( params.nil? || params[:album_id].nil? )
          true # no album - permitted
        else
          ( picture.album.nil? || picture.album.try(:profile).try(:user) == user ) &&
          ( params.nil? || params[:album_id].nil? || ( Album.exists?(params[:album_id]) && Album.find(params[:album_id]).try(:profile).try(:user) == user ) )
        end
      end
    end

    # comment creation is allowed for all logged-in users
    can :create, Comment do |comment|
      comment.try(:profile).try(:user).id > 0 &&
      comment.try(:profile).try(:user) == user
    end

    # profiles can only get changed and only by their owners
    can [:edit, :update], Profile do |profile|
      profile.try(:user) == user
    end

    # everybody can read most of the data
    can :show, [Picture, Album, Comment, PictureMetadata, Profile]
    can :index, [Picture, Album]

    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
