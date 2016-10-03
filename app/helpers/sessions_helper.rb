module SessionsHelper
    def current_user
        # current_userがnilなら右の値を代入する
        @current_user ||= User.find_by(id: session[:user_id])
        # @current_user = @current_user || User.find_by(id: session[:user_id])
    end
    
    def logged_in?
        # current_userが存在する場合、!current_userはfalse, !!current_userでtrue
        # current_userがnilの場合、!current_userはtrue, !!current_userはfalse
        # なぜcurrent_user.
        !!current_user
    end
    
    def store_location
        # ログインが必要なページにアクセスしようとしたときに時にページのURLを保存しておく
        session[:forwarding_url] = request.url if request.get?
    end
end