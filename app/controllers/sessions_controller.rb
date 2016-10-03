class SessionsController < ApplicationController
  def new
  end
  
  def create
    # params session? 何でdowncase
    # セッションのemailからユーザーを取得
    # なぜuser paramsにしない?
    @user = User.find_by(email: params[:session][:email].downcase)
    # 認証成功なら
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:info] = "logged in as #{@user.name}"
      redirect_to @user
    else
      flash[:danger] = "invalid email/password combination"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
