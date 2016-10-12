class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:home]
  
  def home
    @micropost = current_user.microposts.build if logged_in?
    #現在のユーザーのタイムライン投稿取得
    #includesしておくと一覧表示するときにuser情報取得のたびにSQLが走らなくなる
    @feed_items = current_user.feed_items.page(params[:page]).includes(:user).order(created_at: :desc)
  end
end
