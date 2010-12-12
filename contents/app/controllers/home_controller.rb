class HomeController < ApplicationController
  def index
    @picture = Picture.random
  end

end
