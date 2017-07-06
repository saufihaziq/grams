class SessionsController < ApplicationController


    def new
    end
    
    def create
        @user = User.find_by(email: params[:email])
            # If the user exists AND the password entered is correct.
        if @user && @user.authenticate(params[:password])
            # Save the user id inside the browser cookie. This is how we keep the user 
            # logged in when they navigate around our website.
            session[:user] = @user.id
            flash[:success] = "Signed in!"
            redirect_to root_path
        else
            # If user's login doesn't work, send them back to the login form.
            render :new
        end
    end


    def destroy
        #clear out session    
        reset_session
        flash[:danger] = "Signed out."
        redirect_to login_path
    end

    #fb login
    def create_from_omniauth
        auth_hash = request.env["omniauth.auth"]
        authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)
        if authentication.user
            user = authentication.user 
            authentication.update_token(auth_hash)
            flash[:success] = "Signed in!"
        else
            user = User.create_with_auth_and_hash(authentication, auth_hash)  
            flash[:info] = "User created - confirm or edit details..."
        end
        session[:user] = user.id
        redirect_to root_path
  end
end