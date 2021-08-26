class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @bookmarks = @user.bookmarks.page(params[:page]).per(20).order(created_at: :desc)
  end

  def create
    @review = Review.find(params[:review_id])
    bookmark = @review.bookmarks.new(user_id: current_user.id)
    bookmark.user_id = current_user.id
    if bookmark.save
      redirect_to request.referer, notice: "ブックマークへ登録しました"
    else
      redirect_to request.referer, notice: "ブックマークへ登録できません"
    end
  end

  def destroy
    @review = Review.find(params[:review_id])
    bookmark = @review.bookmarks.find_by(user_id: current_user.id)
    if bookmark.present?
      bookmark.destroy
      redirect_to request.referer, notice: "ブックマークから削除しました"
    else
      redirect_to request.referer, notice: "ブックマークから削除できません"
    end
    # bookmark.present?で２度押しのエラーを回避。
  end
end
