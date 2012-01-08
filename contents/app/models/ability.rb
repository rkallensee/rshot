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

    # every user can manage its own pictures and albums
    can :manage, [Picture, Album] do |pa, params|
      pa.try(:profile).try(:user) == user
    end

    # but a picture may only assigned to a users' own album
    can :create, Picture do |picture, params|
      picture.try(:profile).try(:user) == user &&
      ( picture.album.nil? ||
        picture.album.try(:profile).try(:user) == user )
    end
    can :update, Picture do |picture, params|
      picture.try(:profile).try(:user) == user &&
      ( ( picture.album.nil? && ( params.nil? || params[:album_id].nil? ) ) ||
        ( picture.album.try(:profile).try(:user) == user &&
          ( params.nil? || params[:album_id].nil? ||
            ( Album.exists?(params[:album_id]) && Album.find(params[:album_id]).try(:profile).try(:user) == user ) ) ) )
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
