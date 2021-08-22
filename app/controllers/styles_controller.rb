class StylesController < ApplicationController

  def index
    @styles = current_user.styles
    @user = current_user
  end

  def show
    @style = Style.find(params[:id])
    @items = @style.items
    @user = current_user
    if @style.user != current_user
      redirect_to mypage_path
    end
  end

  def new
    @styles = current_user.styles
    @style = Style.new
    @user = current_user
  end

  def create
    @style = Style.new(style_params)
    @style.user_id = current_user.id
    if @style.save
      flash[:succes] = '登録に成功しました'
      redirect_to new_user_style_path(current_user)
    else
      @styles = current_user.styles
      @user = current_user
      render :new
    end
  end

  def edit
    @style = Style.find(params[:id])
    @user = current_user
    if @style.user != current_user
      redirect_to mypage_path
    end
  end

  def update
    @style = Style.find(params[:id])
     if @style.update(style_params)
      flash[:succes] = '情報が更新しました'
      redirect_to new_user_style_path(current_user)
     else
      @user = current_user
      render :edit
     end
  end

  def destroy
    @style = Style.find(params[:id])
    @style.destroy
    redirect_to new_user_style_path(current_user)
  end

  private
  def style_params
    params.require(:style).permit(:name)
  end

end
