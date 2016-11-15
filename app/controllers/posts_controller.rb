class PostsController < ApplicationController
  layout 'post'
  before_action :authenticate_user!
  before_action :check_ownership, only: [:edit, :update, :destroy]

  def index
    # 유저가 로그인상태가 아닐 경우 회원가입페이지로 이동
    unless user_signed_in?
      redirect_to new_user_registration_path
    end

    # @posts = Post.all.order('created_at desc')
    view_users = [current_user]
    current_user.followings.each do |u|
      view_users << u
    end

    @posts = Post.where(user_id: view_users).page(params[:page]).per(10).order('created_at desc')
  end

  def create
    new_post = Post.new(user_id: current_user.id, content: params[:content], image: params[:image])

    if new_post.save
      redirect_to root_path
    else
      redirect_to new_post_path
    end
  end

  def edit
  end

  def update
    @post.content = params[:content]
    @post.image = params[:image] if params[:image].present?

    if @post.save
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def check_ownership
    @post = Post.find_by(id: params[:id])
    redirect_to root_path if @post.user.id != current_user.id
  end
end
