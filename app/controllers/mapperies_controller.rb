class MapperiesController < ApplicationController
  #also don't need to login???
  skip_before_action :authorize, only[:landing, :login]

  def landing
  end

  def login
	puts ""
  end

  def main
	puts ""
  end

  def album
	puts ""
  end

  def friends
	puts ""
  end
end
