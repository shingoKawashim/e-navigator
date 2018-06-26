class InterviewsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user
  before_action :set_interview, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:index, :new, :edit]

  def index
    @interviews = Interview.where(user_id: params[:user_id]).alive_records.page(params[:page]).per(10)
  end

  def new
    @interview = Interview.new
  end

  def create
    @interview = Interview.new(interview_params)
    if @interview.save
      redirect_to user_interviews_path(user_id: current_user.id), flash: {success: t("views.flash.create_success")}
    else
      flash.now[:danger] = t("views.flash.create_danger")
      render :new
    end
  end

  def edit
  end

  def update
    if @interview.update(interview_params)
      redirect_to user_interviews_path(user_id: current_user.id), flash: {success: t("views.flash.update_success")}
    else
      flash.now[:danger] = t("views.flash.update_danger")
      render :edit
    end
  end

  def destroy
    if @interview.all_destroy
      redirect_to user_interviews_path(user_id: current_user.id), flash: {success: t("views.flash.destroy_success")}
    else
      flash.now[:danger] = t("views.flash.destroy_danger")
      render :index
    end
  end

  def approval
    alive = 0
    approval = 2
    reject = 1
    studend_id = params[:user_id]
    focus_interview_id = params[:id]

    interview = Interview.find(focus_interview_id)
    other_alive_interviews = Interview.where("user_id = (?) AND deleted = (?) AND id != (?)", studend_id, alive, focus_interview_id)

    if interview.update(status: approval)
      other_alive_interviews.update_all(status: reject)
      redirect_to user_interviews_path(user_id: studend_id), flash: {success: t("views.flash.approval")}
    else
      flash.now[:danger] = t("views.flash.update_danger")
      render :index
    end
  end

  def reject
    reject = 1
    studend_id = params[:user_id]
    focus_interview_id = params[:id]

    interview = Interview.find(focus_interview_id)
    if interview.update(status: reject)
      redirect_to user_interviews_path(user_id: studend_id), flash: {success: t("views.flash.reject")}
    else
      flash.now[:danger] = t("views.flash.update_danger")
      render :index
    end
  end

  private
    def set_user
    @user = User.find(params[:user_id])
    end

    def set_interview
      @interview = Interview.find(params[:id])
    end

    def interview_params
      params.require(:interview).permit(:start_date).merge(user_id: params[:user_id])
    end

    def correct_user
      @user = User.find(params[:user_id])
      unless @user == current_user || @current_user.mentor?
        redirect_to root_url, flash: {danger: t("views.flash.incorrect_user")}
      end
    end
end
