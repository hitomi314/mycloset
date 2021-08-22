class RelatedItemsController < ApplicationController

  def category
    @categories = current_user.categories
    @user = current_user
    @item = Item.find(params[:id])
  end

  def select
    @related_item = RelatedItem.new
  end

  def confirm
    @cart_items=CartItem.where(customer_id: current_customer)
    @cart_item=CartItem.
  end

  def create
  end

  def destroy
  end

  private
  def related_item_params
    params.require(:related_item).permit(:item_id)
  end

end
