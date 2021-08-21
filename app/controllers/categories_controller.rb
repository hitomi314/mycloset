class CategoriesController < ApplicationController

  def index
    @categories = current_user.categories
  end

  def show
    @category = Category.find(params[:id])
    @item = @category.items
  end

  def create
  end

  def update
  end

  def destroy
  end

  private
  def category_params
    params.require(:item).permit(:name)
  end

end
