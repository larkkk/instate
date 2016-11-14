class ExploreController < ApplicationController
  layout 'post'
  
  def index
    @user_list = User.all
  end
end
