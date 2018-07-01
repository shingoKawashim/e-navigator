class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.alive_records.order(id: :asc).page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save(context: :check_email)
      log_in(@user)
      redirect_to users_path, flash: { success: t("views.flash.create_success") }
    else
      flash.now[:danger] = t("views.flash.create_danger")
      render :new
    end
  end

  def edit
  end

  def update
    @user.attributes = user_params

    if @user.save(context: :check_email)
      redirect_to users_path, flash: { success: t("views.flash.update_success") }
    else
      flash.now[:danger] = t("views.flash.update_danger")
      render :edit
    end
  end

  def destroy
    if @user.all_destroy
      session[:user_id] = nil
      redirect_to root_url, flash: { success: t("views.flash.destroy_success") }
    else
      flash.now[:danger] = t("views.flash.destroy_danger")
      render :edit
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :sex, :birthday, :school, :email, :password, :password_confirmation, :user_type)
    end

    def correct_user
      @user = User.find(params[:id])
      unless @user == current_user
        redirect_to root_url, flash: { danger: t("views.flash.incorrect_user") }
      end
    end
end
