class PicturesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :determine_scope
  
  # GET /pictures
  # GET /pictures.xml
  def index
    @pictures = @scope.find(:all, :order => "created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pictures }
    end
  end

  # GET /pictures/1
  # GET /pictures/1.xml
  def show
    @picture = Picture.find(params[:id])
    
    if params[:album_id]
      @prev_link = album_picture_path(Album.find(params[:album_id]), @scope.previous(@picture.id).first) unless @scope.previous(@picture.id).first.nil?
      @next_link = album_picture_path(Album.find(params[:album_id]), @scope.next(@picture.id).first) unless @scope.next(@picture.id).first.nil?
    elsif params[:profile_id]
      @prev_link = profile_picture_path(Profile.find(params[:profile_id]), @scope.previous(@picture.id).first) unless @scope.previous(@picture.id).first.nil?
      @next_link = profile_picture_path(Profile.find(params[:profile_id]), @scope.next(@picture.id).first) unless @scope.next(@picture.id).first.nil?
    else
      @prev_link = @scope.previous(@picture.id).first
      @next_link = @scope.next(@picture.id).first
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @picture }
    end
  end

  # GET /pictures/new
  # GET /pictures/new.xml
  def new
    @picture = Picture.new
    @albums = Album.where("user_id" => current_user.id).order("title ASC")

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @picture }
    end
  end

  # GET /pictures/1/edit
  def edit
    @picture = Picture.find(params[:id])
    @albums = Album.where("user_id" => current_user.id).order("title ASC")
  end

  # POST /pictures
  # POST /pictures.xml
  def create
    @picture = Picture.new(params[:picture])
    @picture.user_id = current_user.id

    respond_to do |format|
      if @picture.save
        format.html { redirect_to(@picture, :notice => 'Picture was successfully created.') }
        format.xml  { render :xml => @picture, :status => :created, :location => @picture }
      else
        @albums = Album.where("user_id" => current_user.id).order("title ASC")
        format.html { render :action => "new" }
        format.xml  { render :xml => @picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.xml
  def update
    @picture = Picture.find(params[:id])
    @picture.user_id = current_user.id

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        format.html { redirect_to(@picture, :notice => 'Picture was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.xml
  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to(pictures_url) }
      format.xml  { head :ok }
    end
  end
  
  protected

    # get scope - since picture resource is also nested in album resource
    def determine_scope
      @scope = if params[:album_id]
        Album.find(params[:album_id]).pictures
      elsif params[:profile_id]
        Profile.find(params[:profile_id]).user.pictures
      else
        Picture
      end
    end
end
