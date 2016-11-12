class PostsController < ApplicationController
  def index
    # 유저가 로그인상태가 아닐 경우 회원가입페이지로 이동
    unless user_signed_in?
      redirect_to new_user_registration_path
    end
  end
end
