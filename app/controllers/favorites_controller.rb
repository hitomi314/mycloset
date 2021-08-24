class FavoritesController < ApplicationController

  def create
    @review = Review.find(user_id: params[:user_id],item_id: params[:item_id], review_id: params[:review_id])
    favorite = current_user.favorites.new(review_id: @review.id)
    favorite.save
  end

  def destroy
    @review = Review.find(params[:user_id][:item_id][:review_id])
    favorite = current_user.favorites.find_by(book_id: @review.id)
    favorite.destroy
  end

end
