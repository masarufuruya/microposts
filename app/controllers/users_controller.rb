class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  #ログインしていない場合はリダイレクト
  before_action :redirect_unlogged_user, only: [:show, :edit, :update]
  #自分以外のユーザーが編集できないようにする
  before_action :forbid_other_user_edit, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @user.update(update_params)
      flash[:success] = '更新しました'
      redirect_to edit_user_path(@user)
    else
      flash[:danger] = '更新に失敗しました'
      render 'edit'
    end
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
  
  private
    def set_user
      @user = User.find(params[:id])
    end

    def redirect_unlogged_user
      unless logged_in?
        redirect_to root_path
      end
    end
    
    def forbid_other_user_edit
      if current_user != @user
        redirect_to root_path
      end
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def update_params
      params.require(:user).permit(:name, :email, :description, :password, :password_confirmation)
    end
end
