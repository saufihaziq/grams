class CommentsController < ApplicationController
    before_action :sign_in?
    def new
    end

    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.new(comment_params)
        @comment.user_id = current_user.id
        if @comment.save
            redirect_to root_path
        end
    end
    
    private
    
    def comment_params
        params.require(:comment).permit(:comments)
    end
    
     def sign_in?
        if current_user.nil?
            flash[:danger] = 'Please sign in.'
            redirect_to '/login'
        end 
end  

end