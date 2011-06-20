class AlbumsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]

  before_filter :get_profile

  def get_profile
    @profile = Profile.find(params[:profile_id])
  end

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
        format.html { redirect_to(@album, :notice => 'Album was successfully created.') }
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
    @album = current_user.profile.find(params[:id])
    @album.profile_id = current_user.id ## problematic! check profile_id instead of overwriting it.

    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to(@album, :notice => 'Album was successfully updated.') }
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
    @album = current_user.profile.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to(albums_url) }
      format.xml  { head :ok }
    end
  end

end
