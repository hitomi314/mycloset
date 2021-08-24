class SaerchController < ApplicationController

  def saerch
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]
    @items = search_for(@model, @content, @method).order(created_at: :desc)
    @reviews = search_for(@model, @content, @method).order(created_at: :desc)
    # #=>新しい順の投稿一覧 #created_atは作成日時　descは降順 古い順の投稿一覧は:asc。ascは昇順
  end

  private

  def search_for(model, content, method)
    if model == 'reviewname'
      if method == 'perfect'
        Review.where(name: content)
      elsif method == 'partial'
        Review.where('name LIKE ?', '%'+content+'%')
      elsif method == 'forward'
        Review.where('name LIKE ?', ''+content+'%')
      elsif method == 'backward'
        Review.where('name LIKE ?', '%'+content+'')
      else
        Review.all
      end

    elsif model == 'reviewbrand'
      if method == 'perfect'
        Review.where(brand: content)
      elsif method == 'partial'
        Review.where('brand LIKE ?', '%'+content+'%')
      elsif method == 'forward'
        Review.where('brand LIKE ?', ''+content+'%')
      elsif method == 'backward'
        Review.where('brand LIKE ?', '%'+content+'')
      else
        Review.all
      end

    elsif model == 'itemname'
      if method == 'perfect'
        Item.where(name: content, user_id: current_user.id)
      elsif method == "partial"
        current_user.items.where('name LIKE ?', '%'+content+'%')
      elsif method == "forward"
        current_user.items.where('name LIKE ?', ''+content+'%')
      elsif method == "backward"
        current_user.items.where('name LIKE ?', '%'+content+'')
      else
        current_user.items.all
      end

    elsif model == 'itembrand'
      if method == 'perfect'
        Item.where(brand: content, user_id: current_user.id)
      elsif method == "partial"
        current_user.items.where('brand LIKE ?', '%'+content+'%')
      elsif method == "forward"
        current_user.items.where('brand LIKE ?', ''+content+'%')
      elsif method == "backward"
        current_user.items.where('brand LIKE ?', '%'+content+'')
      else
        current_user.items.all
      end
    end
  end

end
