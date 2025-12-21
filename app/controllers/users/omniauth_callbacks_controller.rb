class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    auth = request.env["omniauth.auth"]

    user = User.find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    user.email = auth.info.email if user.email.blank?
    user.password = Devise.friendly_token[0, 20] if user.encrypted_password.blank?

    # username を必須にしている場合、初期値を自動生成（必要なら）
    if user.respond_to?(:username) && user.username.blank?
      base = auth.info.name.presence || auth.info.email.split("@").first
      user.username = base.to_s.first(20)
    end

    user.save!

    sign_in_and_redirect user, event: :authentication
  rescue ActiveRecord::RecordInvalid => e
    redirect_to new_user_session_path, alert: "Googleログインに失敗しました: #{e.record.errors.full_messages.join(", ")}"
  end

  def failure
    redirect_to root_path, alert: "認証に失敗しました"
  end
end
