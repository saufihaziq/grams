class BuyingsController < ApplicationController

    def new
    end
    
    def create
        @post = Post.find(params[:post_id])
        @buying = current_user.buyings.new(buying_params)
        @buying.post = @post

        if @buying.save
            redirect_to post_buying_path(@post,@buying)
        else
            flash[:danger] = "Something seems to be wrong"
            render :new
        end
    end

    def show
        @buying = Buying.find(params[:id])
    end
    

    
    private

    def buying_params
        params.require(:buying).permit(:address)
    end
    
end