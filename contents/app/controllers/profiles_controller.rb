class ProfilesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  # GET /profiles/1
  # GET /profiles/1.xml
  def show
    @profile = Profile.find_by_nick(params[:id])
    @pictures = Picture.find_all_by_profile_id(@profile.id)
    @albums = Album.find_all_by_profile_id(@profile.id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    @profile = Profile.find_by_nick(params[:id])
  end

  # PUT /profiles/1
  # PUT /profiles/1.xml
  def update
    @profile = Profile.find_by_nick(params[:id])

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to(@profile, :notice => 'Profile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end
end
