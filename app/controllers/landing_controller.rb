class LandingController < ApplicationController
  #no login needed for the landing page
  skip_before_action :authorize

  def show
  end
end
