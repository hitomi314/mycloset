class ItemsController < ApplicationController

  def index
    @items = current_user.items.page(params[:page]).per(20)
    @user = current_user
  end

  def show
    @item = Item.find(params[:id])
    @user = current_user
     if @item.user != current_user
        redirect_to mypage_path
     end
  end

  def new
    @item = Item.new
    @categories = current_user.categories
    @styles = current_user.styles
  # @image = @item.images.build
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    @categories = current_user.categories
    @styles = current_user.styles
    if @item.save
      flash[:succes] = 'アイテムがクローゼットに入りました'
      redirect_to user_item_path(current_user, @item)
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
    @categories = current_user.categories
    @styles = current_user.styles
      if @item.user != current_user
        redirect_to mypage_path
      end
  end

  def update
    @item = Item.find(params[:id])
    @categories = current_user.categories
    @styles = current_user.styles
     if @item.update(item_params)
      flash[:succes] = 'アイテム情報が更新しました'
      redirect_to user_item_path(current_user, @item)
     else
      render :edit
     end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to user_items_path(current_user)
  end

  private
  def item_params
    params.require(:item).permit(:category_id, :style_id, :name, :brand, :color, :color_code, :item_sex, :size, :material, :buy_day, :season, :price, images_images: [], related_items:[])
  end
#images_images: []images(モデル名)_images(refileで画像投稿するときの規則名): [](複数投稿するときに必要)
end