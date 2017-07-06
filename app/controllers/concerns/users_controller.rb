class UsersController < ApplicationController
    before_action :find_user, only: [:show, :edit, :update]

    def index
        @user = User.new
        # @posts = Post.all.order("created_at DESC")
        # @comment = Comment.new

        @filterrific = initialize_filterrific(User, params[:filterrific],
            select_options: {
            sorted_by: User.options_for_sorted_by
        },
        ) or return

        @users = @filterrific.find

        respond_to do |format|
            format.html
            format.js
        end
    end
    
    
    def new
        @user = User.new
    end
    

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "User has been created"
            redirect_to login_path
        else
            flash.now[:danger] = "Invalid input"
            render :new
        end
    end

    def show
        @user_post = @user.posts.order("created_at DESC")
    end
    
    def edit
    end
    
    def update
        @user.update(update_params)
            if @user.save(validate: false)
            flash[:success] = "Profile updated"
            redirect_to @user
        else
            flash.now[:danger] = "Update failed"
            render :edit
        end
    end
    
        

    private

    def user_params
        params.require(:user).permit(:email, :fullname, :username, :password)
    end
    
    def update_params
        params.require(:user).permit(:email, :fullname, :username, :password, :website, :bio, :gender, :phone_num, :avatar)
    end

    def find_user
        @user = User.find(params[:id])
    end
    
    
end