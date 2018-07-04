class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  private

    def require_user_logged_in
      unless logged_in?
        redirect_to login_url, flash: { danger: t("views.flash.non_logged_in_user") }
      end
    end
end
