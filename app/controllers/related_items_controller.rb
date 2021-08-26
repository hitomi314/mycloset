class RelatedItemsController < ApplicationController
  def category
    @categories = current_user.categories
    @user = current_user
    @item = Item.find(params[:item_id])
  end

  def select
    @category = Category.find(params[:id])
    @related_item = RelatedItem.new
    @user = current_user
    @items = @category.items.page(params[:page]).per(20)
  end

  def confirm
    @item = Item.find(params[:item_id])
    @user = current_user
    @related_items = RelatedItem.where(parentitem_id: params[:item_id]).order(created_at: :desc)
    # @related_items = @item.related_items
    # @items = []
    # @related_items.each do |reitem|
    #   item = Item.find(reitem.item_id)
    #   @items.push(item)
    # pushでitems=[]の中に代入する変数（Item）：item = Item.find(reitem.item_id)を指定する
    # end
  end

  def add
    @related_item = RelatedItem.new(related_item_params)
    @item = Item.find(params[:item_id])
    @related_item.parentitem_id = @item.id
    if params[:related_item].nil?
      @related_item.item_id = params[:item_id]
    else
      @related_item.item_id = params[:related_item][:item_id]
    end
    @related_item.save
    redirect_to user_item_related_items_confirm_path, notice: "関連アイテムを登録しました"
  end

  def destroy
    @related_item = RelatedItem.find(params[:id])
    @related_item.destroy
    redirect_to user_item_related_items_confirm_path, notice: "関連アイテムを削除しました"
  end

  # def destroy_all
  #   @user = current_user
  #   @item = Item.find(params[:item_id])
  #   @related_items = RelatedItem.where(parentitem_id: params[:item_id])
  #   @related_items.destroy
  #   redirect_to user_item_path(@user, @item)
  # end

  private

  def related_item_params
    params.require(:related_item).permit(:item_id)
  end
end
