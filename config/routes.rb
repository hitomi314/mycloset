Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'saerch' => 'saerch#saerch'
  get 'mypage' => 'users#mypage', as:'mypage'
  get 'mypage/edit' => 'users#edit', as:'edit_mypage'
      #resourceでeditを作成するとdeviseのedit_user_registrationパスと同じURIになるため、個別にURとパスを作成して対応
    patch 'mypage/edit' => 'users#update'
      #resourceでupdateを作成すると、上記のuserパスに対してpatchはあるが、edit_userパスにはpatchがないため、ルーティングエラーが発生する
      #これを回避するためにresourceではなく個別にパスを作成した
    post 'users/caution' => 'users#caution'
      #退会確認画面
    patch 'users/hide' => 'users#hide'
  resources :users, only: [:show] do
    resources :categories
    resources :styles
    resources :bookmarks, only: [:index, :create, :destroy]
    resources :items do
      resources :related_items, only: [ :destroy]
         get 'related_items/categories',to: 'related_items#category', as:"related_items_category"
         get 'related_items/categories/:id',to: 'related_items#select', as:"related_items_select"
         get 'related_items/confirm',to: 'related_items#confirm'
         post 'related_items/confirm',to: 'related_items#add'
        # delete 'related_items/destroy_all' => 'related_items#destroy_all', as:'related_items_destroy_all'
      resources :images, only: [:create, :destroy]
      resources :reviews do
        resource :favorites, only: [:create, :destroy]
      end
    end
  end
end
