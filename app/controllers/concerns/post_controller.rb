class PostsController < ApplicationController
    before_action :find_post, only: [:show, :edit, :update, :destroy]

    def index
        @posts = Post.all.order("created_at DESC") 
        @comment = Comment.new
        @user = User.new
    end
    

    def new
        @post = Post.new
    end
    
    def create
       
        @post = Post.new(create_params)
        @post.user_id = current_user.id
        @post.time = Time.now
        if @post.save
            flash[:success] = "Post has been created."
            redirect_to post_path(@post)
        else
            flash.now[:danger] = "There's seem to be an error."
            render :new

        end
    end
    
    def show
        @buying = Buying.new
    end
    
    def edit
    end
    
    def update
        @post.update(update_params)
        if @post.save
            flash[:success] = "Updated."
            redirect_to @post
        else
            flash.now[:danger] = "Update fail."
            render :edit
        end
    end
    
    def destroy
    end
    

    private

    def create_params
        params.require(:post).permit(:caption, {images: []}, :price)
    end
    
    def update_params
        params.require(:post).permit(:caption)
    end
    

    def find_post
        @post = Post.find(params[:id])
    end
    
end
