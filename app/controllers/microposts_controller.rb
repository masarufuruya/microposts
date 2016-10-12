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
      post = Micropost.find(params[:id])
      if post.likes.create(user_id: current_user.id)
        flash[:success] = "お気に入りしました"
      else
        flash[:danger] = "お気に入りに失敗しました"
      end
      redirect_to :back
    end
    
    def unfavorite
      post = Micropost.find(params[:id])
      post_like = post.likes.find_by(user_id: current_user.id)
      begin
        post_like.destroy! unless post_like.nil?
        flash[:success] = "お気に入り解除しました"
      rescue
        flash[:danger] = "お気に入り解除に失敗しました"
      end
      redirect_to :back
    end
    
    private
        def micropost_params
          params.require(:micropost).permit(:content)
        end
end
