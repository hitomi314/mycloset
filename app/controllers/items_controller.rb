class ItemsController < ApplicationController

  def index
    @items = current_user.items
  end

  def show
    @item = Item.find(params[:id])
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
    if @item.save
      flash[:succes] = 'アイテムがクローゼットに入りました'
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
      if @item.user != current_user
        redirect_to mypage_path
      end
  end

  def update
    update
    @item = Item.find(params[:id])
     if @item.update(book_params)
      flash[:succes] = 'アイテム情報が更新しました'
      redirect_to item_path(@item)
     else
      render :edit
     end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
  end

  private
  def item_params
    params.require(:item).permit(:category_id, :style_id, :name, :brand, :color, :color_code, :item_sex, :size, :material, :season, :buy_day, :price, images_images: [] )
  end
#images_images: []images(モデル名)_images(refileで画像投稿するときの規則名): [](複数投稿するときに必要)
end