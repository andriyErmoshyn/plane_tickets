class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      create_new_session(user) do
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)  
      end
    else
      flash.now[:danger] = "Invalid login/password information."
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

    def create_new_session(user)
      flash[:success] = "You logged in successfully!"
      log_in user
      yield if block_given?
      if user.admin?
        redirect_to admin_routes_path
      else
        redirect_to root_url
      end
    end

end
