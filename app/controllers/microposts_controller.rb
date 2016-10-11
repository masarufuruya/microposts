class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create]
    
    def create
        #micropostsにuser_idが入る。micropostsを初期化
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
          flash[:success] = "Micropost created!"
          redirect_to root_url
        else
          @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
          render 'static_pages/home'
        end
    end
    
    def destroy
        # find_byではなく、findにすると例外(ActiveRecord::RecordNotFound)が発生してnilcheckできない
        @micropost = current_user.microposts.find_by(id: params[:id])
        # return redirect_to root_url if @micropost.nil?
        begin
          @micropost.destroy!
          flash[:success] = "削除しました"
          redirect_to request.referrer || root_url
        rescue
          # e.messageでとれる
          flash[:danger] = "削除に失敗しました"
          redirect_to root_url
        end
    end
    
    private
        def micropost_params
            params.require(:micropost).permit(:content)
        end
end
