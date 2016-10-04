class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create]
    
    def create
        #micropostsにuser_idが入る。micropostsを初期化
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
          flash[:success] = "Micropost created!"
          redirect_to root_url
        else
          render 'static_pages/home'
        end
    end
    
    def destroy
    end
    
    private
        def micropost_params
            params.require(:micropost).permit(:content)
        end
end
