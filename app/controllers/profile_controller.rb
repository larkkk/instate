class ProfileController < ApplicationController
  def index
    @find_user = User.find_by(identify: params[:identify])
  end
end