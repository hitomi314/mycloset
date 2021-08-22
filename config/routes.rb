Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'search' => 'searchs#search'
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
      resources :related_items, only: [:create, :destroy]
         get 'related_items/category',to: 'related_items#category'
         get 'related_items/select',to: 'related_items#select'
         post 'related_items/confirm',to: 'related_items#confirm'
      resources :images, only: [:create, :destroy]
      resources :reviews do
        resources :favorites, only: [:create, :destroy]
      end
    end
  end
end
