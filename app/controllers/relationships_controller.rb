class RelationshipsController < ApplicationController
    
    def create
        @user = User.find(params[:followed_id])
        current_user.follow(@user)
    end
    
    def destroy
        @user = current_user.following_relationships.find(params[:id]).followed_user
        current_user.unfollow(@user)
    end
    
end
