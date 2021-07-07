class RelationshipsController < ApplicationController

    def follow
        current_user.follow(params[:id])
        redirect_to users_path
    end

    def unfollow
        current_user.unfollow(params[:id])
        redirect_to users_path
    end

    def followings
        @user = current_user
        @followings = current_user.following_user
    end

    def followers
        @user = current_user
        @followers = current_user.follower_user
    end

    # def create
    #     user = User.find(params[:user_id])
    #     follows = current_user.follower.new(followed_id: user.id)
    #     follows.save
    #     redirect_to user_path(user)
    # end

    # def destroy
    #     user = User.find(params[:user_id])
    #     follows = current_user.follower.find_by(followed_id: user.id)
    #     follows.destroy
    #     redirect_to user_path(user)
    # end

end
