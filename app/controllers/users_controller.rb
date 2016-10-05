class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
    #一旦showにまとめる
    @following_users = @user.following_users
    @follower_users = @user.follower_users
  end
  
  #ユーザー新規登録
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザー登録しました'
      redirect_to @user
    else
      #バリデーション結果のuserオブジェクトをそのままnewを出す
      render 'new'
    end
  end
  
  #各ユーザーがフォローしているユーザー一覧を取得
  def following_users
    #idからフォローしているuser
    @user = User.find(params[:id])
    @user.following_users
  end
  
  #各ユーザーがフォローされているユーザー一覧を取得
  def follower_users
    @user = User.find(params[:id])
    @user.follower_users
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
