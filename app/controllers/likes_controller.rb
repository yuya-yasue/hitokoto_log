class LikesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post
  
    def create
      current_user.likes.create(post: @post)
  
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "like_button_#{@post.id}",
            partial: "likes/like_button",
            locals: { post: @post }
          )
        end
  
        format.html { redirect_back fallback_location: root_path, notice: "いいねしました" }
      end
    end
  
    def destroy
      current_user.likes.find_by(post_id: @post.id)&.destroy
  
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "like_button_#{@post.id}",
            partial: "likes/like_button",
            locals: { post: @post }
          )
        end
  
        format.html { redirect_back fallback_location: root_path, notice: "いいねを取り消しました" }
      end
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  end