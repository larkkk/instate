class ProfileController < ApplicationController
  layout 'post'

  def index
    @find_user = User.find_by(identify: params[:id])
    @posts = @find_user.posts.order('created_at desc')
  end
end
