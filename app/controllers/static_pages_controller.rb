class StaticPagesController < ApplicationController
  def home
    @micropost = current_user.microposts.build if logged_in?
    #現在のユーザーのタイムライン投稿取得
    #includesしておくと一覧表示するときにuser情報取得のたびにSQLが走らなくなる
    @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
  end
end
