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

class AlbumsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :get_profile

  # GET /albums
  # GET /albums.xml
  def index
    @albums = @profile.albums.order('created_at DESC').page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.xml
  def show
    @album = @profile.albums.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/new
  # GET /albums/new.xml
  def new
    @album = @profile.albums.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @album = @profile.albums.find(params[:id])
  end

  # POST /albums
  # POST /albums.xml
  def create
    @album = @profile.albums.new(params[:album])
    @album.profile_id = current_user.profile.id
    # think about security / permissions!

    respond_to do |format|
      if @album.save
        format.html { redirect_to([@profile, @album], :flash => {:success => 'Album was successfully created.'}) }
        format.xml  { render :xml => @album, :status => :created, :location => @album }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.xml
  def update
    @album = current_user.profile.albums.find(params[:id])
    @album.profile_id = current_user.id ## problematic! check profile_id instead of overwriting it.

    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to([@album.profile, @album], :flash => {:success => 'Album was successfully updated.'}) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.xml
  def destroy
    @album = current_user.profile.albums.find(params[:id])
    @album.destroy

    # todo: only destroy albums without pictures. or at least remove references to albums.

    respond_to do |format|
      format.html { redirect_to(profile_albums_url(@profile)) }
      format.xml  { head :ok }
    end
  end

  protected
    def get_profile
      @profile = Profile.find_by_nick(params[:profile_id])
    end

end
