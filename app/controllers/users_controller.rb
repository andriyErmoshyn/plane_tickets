class UsersController < ApplicationController
  load_and_authorize_resource

  def create
    if @user.save
      log_in @user
      flash[:success] = "You signed up successfully!"
      redirect_to root_url
    else
      flash.now[:danger] = "Something went wrong. Try again, please."
      render 'new'
    end
  end

  def show
    @tickets = current_user.tickets.order(created_at: :desc)
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name,
                                                              :phone_number, :password,
                                                              :password_confirmation)
    end
end
