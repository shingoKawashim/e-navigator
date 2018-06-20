class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      redirect_to root_url, flash: {success: t("views.flash.login_success")}
    else
      flash.now[:danger] = t("views.flash.login_danger")
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, flash: {success: t("views.flash.logout_success")}
  end

  private

    def login(email, password)
      @user = User.alive_records.find_by(email: email)
      if @user && @user.authenticate(password)
        session[:user_id] = @user.id
        return true
      else
        return false
      end
    end
end
