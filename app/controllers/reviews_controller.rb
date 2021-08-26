class ReviewsController < ApplicationController
  def index
    @user = current_user
    @reviews = @user.reviews.page(params[:page]).per(20)
    case params[:sort]
    when "0"
      reviews = @user.reviews.includes(:favorited_users).sort { |a, b| b.favorited_users.size <=> a.favorited_users.size }
      @reviews = Kaminari.paginate_array(reviews).page(params[:page]).per(20)
    when "1"
      @reviews = @user.reviews.page(params[:page]).per(20).order(created_at: :desc)
    when "2"
      @reviews = @user.reviews.page(params[:page]).per(20).order(created_at: :asc)
    else
      @reviews = @user.reviews.page(params[:page]).per(20).order(created_at: :desc)
    end
  end

  def show
    @item = Item.find(params[:item_id])
    @user = current_user
    @review = @item.review
    @images = @item.images
  end

  def new
    @item = Item.find(params[:item_id])
    @user = current_user
    @review = Review.new
    @images = @item.images
  end

  def create
    @review = Review.new(review_params)
    @item = Item.find(params[:item_id])
    @user = current_user
    @review.item_id = @item.id
    @review.user_id = current_user.id
    if @review.save
      redirect_to user_item_review_path(@user, @item, @review), notice: "レビューを投稿しました"
    else
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
    @item = Item.find(params[:item_id])
    @user = current_user
    @images = @item.images
    if @review.user != current_user
      redirect_to mypage_path
    end
  end

  def update
    @review = Review.find(params[:id])
    @item = Item.find(params[:item_id])
    @user = current_user
    if @review.update(review_params)
      redirect_to user_item_review_path(@user, @item, @review), notice: "レビューを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    # @item = Item.find(params[:item_id])
    @user = current_user
    @review.destroy
    redirect_to user_item_reviews_path(@user), notice: "レビューを削除しました"
  end

  def search
    selection = params[:keyword]
    @reviews = current_user.reviews.sort(selection)
  end

  private

  def review_params
    params.require(:review).permit(:rate, :text, :name, :brand)
  end
end
