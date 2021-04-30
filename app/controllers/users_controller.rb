class UsersController < ApplicationController
    before_action :logged_in_user, only: [:edit, :update]
    before_action :correct_user, only: [:edit, :update]

    def show
        @user = User.find(params[:id])
        # debugger
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            reset_session
            log_in @user
            flash[:success] = "Welcome to the Sample App!"
            redirect_to @user
        else
            render 'new'
        end
    end

    def edit
        # @user = User.find(params[:id])
    end

    def update
        # @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:success] = "Profile updated"
            redirect_to @user
        else
            render 'edit'
        end
    end

    # Filters params before creating or editing
    private def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end


    # Checks if a user is logged in
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = "Please log in."
            redirect_to login_path
        end
    end

    # Checks if the current user is the correct user
    def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user)
    end
end
