class UsersController < ApplicationController
  def mypage
    @user = current_user
    @items = @user.items
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.page(params[:page]).per(10).order(created_at: :desc)
    @items = @user.items
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypage_path, notice: "会員情報を更新しました"
    else
      render "edit", notice: "会員情報を更新できませんでした"
    end
  end

  def caution
  end

  def hide
    @user = current_user
    @user.update(is_valid: true)
    reset_session
    # すべてのセッション情報を削除
    redirect_to root_path, notice: "退会処理しました"
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :sex, :height, :weight, :skelton, :body, :close_size, :pasonal_color)
  end
end
