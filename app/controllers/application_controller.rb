class ApplicationController < ActionController::Base
   before_action :authenticate_user!,except: [:top]
   #ログイン前はトップ画面以外アクセス不可
   before_action :configure_permitted_parameters, if: :devise_controller?

  protected

   def after_sign_in_path_for(resource)
     mypage_path
   end
   #ログイン後はマイページへ偏移

   def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :sex, :height, :weight, :skelton, :body, :close_size, :pasonal_color])
   end

   Refile.secret_key = '0fe8ccf18150b24eae74bfad5de95960a80f12f5d77a25219c8593381badf36a215d523ae01f5c5bdb37b9f0577952659474655a48f36064bb143c80ddcf0e13'

end
