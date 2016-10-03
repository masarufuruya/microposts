class UsersController < ApplicationController
  before_action :redirect_unlogged_user, only: [:show, :edit, :update, :create]
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(update_params)
      flash[:success] = '更新しました'
      redirect_to @user
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
    def redirect_unlogged_user
      unless logged_in?
        redirect_to root_path
      end
    end
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def update_params
      params.require(:user).permit(:name, :email, :description)
    end
end
