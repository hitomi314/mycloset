class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories
    @user = current_user
  end

  def show
    @category = Category.find(params[:id])
    @items = @category.items.page(params[:page]).per(15).order(created_at: :desc)
    @user = current_user
    if @category.user != current_user
      redirect_to mypage_path
    end
  end

  def new
    @categories = current_user.categories
    @category = Category.new
    @user = current_user
  end

  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id
    if @category.save
      redirect_to new_user_category_path(current_user), notice: "カテゴリーを登録しました"
    else
      @categories = current_user.categories
      @user = current_user
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
    @user = current_user
    if @category.user != current_user
      redirect_to mypage_path
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to new_user_category_path(current_user), notice: "カテゴリーを更新しました"
    else
      @user = current_user
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to new_user_category_path(current_user), notice: "カテゴリーを削除しました"
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
