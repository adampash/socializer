class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  protect_from_forgery with: :exception, :except => :google_oauth2
  def google_oauth2
    if User.whitelisted? request.env["omniauth.auth"]["info"]["email"]

      @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        reset_session
        session[:user_id] = @user.id
        redirect_to login_success_url
      else
        session["devise.google_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    else
      flash[:alert] = "You need to log in with your Gawker Media account"
      redirect_to login_instructions_url
    end
  end
end

