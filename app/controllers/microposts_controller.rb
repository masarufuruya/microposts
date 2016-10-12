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
    
    def retweet
      #元の投稿を取得
      #実行時にオープンされる(事前に読み込まない)
      origin_post = Micropost.find(params[:id])
      retweet = current_user.microposts.build(origin_user_id: origin_post.id)
      #.xxxが一般的
      retweet.content = origin_post[:content]
      
      if retweet.save
        flash[:success] = "リツイートしました"
        redirect_to root_url
      else
        flash[:danger] = "リツイートに失敗しました"
        #色々な所で呼ばれるので、実行元へ戻す
        redirect_to :back
      end
    end
    
    def favorite
      # is_favoritedがtrue お気に入り
      post = Micropost.find(params[:id])
      # UPDATE posts SET is_favorited = true, updated_at = xx where posts.id = xx
      if post.update(is_favorited: true)
        flash[:success] = "お気に入りしました"
        redirect_to root_url
      else
        flash[:danger] = "お気に入りに失敗しました"
        redirect_to :back
      end
    end
    
    def unfavorite
      post = Micropost.find(params[:id])
      if post.update(is_favorited: false)
        flash[:success] = "お気に入りを解除しました"
        redirect_to root_url
      else
        flash[:danger] = "お気に入りの解除に失敗しました"
        redirect_to :back
      end
    end
    
    private
        def micropost_params
          params.require(:micropost).permit(:content)
        end
end
