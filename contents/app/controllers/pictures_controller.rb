class PicturesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :determine_scope

  # GET /pictures
  # GET /pictures.xml
  def index
    @pictures = @scope.order('created_at DESC').page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pictures }
    end
  end

  # GET /pictures/1
  # GET /pictures/1.xml
  def show
    @picture = Picture.find(params[:id])

    set_prev_next_picture_data

    @comments = @picture.comments.recent.all
    @comment = @picture.comments.new

    if @viewscope == 'album'
      @create_comment_url = create_comment_profile_album_picture_path(@picture.profile, @picture.album, @picture)
    else
      @create_comment_url = create_comment_profile_picture_path(@picture.profile, @picture)
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
    @albums = Album.where("profile_id" => current_user.profile.id).order("title ASC")

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @picture }
    end
  end

  # GET /pictures/1/edit
  def edit
    @picture = Picture.find(params[:id])
    @albums = Album.where("profile_id" => current_user.profile.id).order("title ASC")
  end

  # POST /pictures
  # POST /pictures.xml
  def create
    @picture = Picture.new(params[:picture])
    @picture.profile_id = current_user.profile.id

    respond_to do |format|
      if @picture.save
        format.html { redirect_to(profile_picture_url(current_user.profile, @picture), :flash => {:success => 'Picture was successfully created.'}) }
        format.xml  { render :xml => @picture, :status => :created, :location => @picture }
      else
        @albums = Album.where("profile_id" => current_user.profile.id).order("title ASC")
        format.html { render :action => "new" }
        format.xml  { render :xml => @picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.xml
  def update
    @picture = Picture.find(params[:id])
    @picture.profile_id = current_user.profile.id

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        format.html { redirect_to(scoped_picture_url, :flash => {:success => 'Picture was successfully updated.'}) }
        format.xml  { head :ok }
      else
        @albums = Album.where("profile_id" => current_user.profile.id).order("title ASC")
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
      format.html { redirect_to(profile_pictures_url(current_user.profile)) }
      format.xml  { head :ok }
    end
  end

  # POST /pictures/1/create_comment
  def create_comment
    @picture = Picture.find(params[:id])
    @comment = @picture.comments.new(params[:comment])
    @comment.profile_id = current_user.profile.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to(scoped_picture_url, :flash => {:success => 'Comment was successfully created.'}) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        set_prev_next_links
        @comments = @picture.comments.recent.all
        # todo: DRY! three lines on top!
        flash[:error] = 'Please actually type in a comment!'
        format.html { render :action => "show" }
        format.xml  { render :xml => @picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  protected

    # get scope - since picture resource is also nested in album resource
    def determine_scope
      @scope = Picture.scoped
      @viewscope = 'all'

      if params[:album_id]
        @viewscope = 'album'
        @scope = @scope.by_album(params[:album_id])
      elsif params[:profile_id]
        @viewscope = 'profile'
        @profile = Profile.find_by_nick(params[:profile_id])
        @scope = @scope.by_profile(@profile)
      end
    end

    # set links to previous and next image as instance variables
    def set_prev_next_picture_data
      @prev_picture = @scope.previous(@picture.id).first
      @next_picture = @scope.next(@picture.id).first

      if params[:album_id]
        @prev_link = profile_album_picture_path(Profile.find_by_nick(params[:profile_id]), Album.find(params[:album_id]), @prev_picture) unless @prev_picture.nil?
        @next_link = profile_album_picture_path(Profile.find_by_nick(params[:profile_id]), Album.find(params[:album_id]), @next_picture) unless @next_picture.nil?
        @back_link = profile_album_path(Profile.find_by_nick(params[:profile_id]), Album.find(params[:album_id]))
      elsif params[:profile_id]
        @prev_link = profile_picture_path(Profile.find_by_nick(params[:profile_id]), @prev_picture) unless @prev_picture.nil?
        @next_link = profile_picture_path(Profile.find_by_nick(params[:profile_id]), @next_picture) unless @next_picture.nil?
        @back_link = profile_pictures_path(Profile.find_by_nick(params[:profile_id]))
      end
    end

    # get redirect path to picture (used after editing and comment creation)
    def scoped_picture_url
      if params[:album_id]
        profile_album_picture_url(Profile.find_by_nick(params[:profile_id]), Album.find(params[:album_id]), Picture.find(params[:id]))
      elsif params[:profile_id]
        profile_picture_url(Profile.find_by_nick(params[:profile_id]), Picture.find(params[:id]))
      end
    end
end
