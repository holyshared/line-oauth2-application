class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  def line
    if current_user.blank?
      Rails.logger.info 'Not signed in ^^^^^^^^^^^^^^^^^^^^^^^'
    else
      Rails.logger.info 'Signed in ^^^^^^^^^^^^^^^^^^^^^^^^^^^'
    end
    @user = User.find_or_create_omniauth!(request.env['omniauth.auth'])
    sign_in_and_redirect @user, event: :authentication
    set_flash_message(:notice, :success, kind: 'Line') if is_navigational_format?
  rescue => e
    Rails.logger.error e
    set_flash_message(:error, :failure, kind: 'Line', reason: 'nanka!!')
    redirect_to new_user_session_path
  end

  def failure
    redirect_to root_path
  end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
