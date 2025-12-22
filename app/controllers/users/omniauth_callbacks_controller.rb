class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    auth = request.env["omniauth.auth"]
    raise "omniauth.auth is missing" if auth.blank?

    provider = auth.provider
    uid = auth.uid
    email = auth.info.email.to_s

    # 1) まず provider/uid で既存ユーザーを探す
    user = User.find_by(provider: provider, uid: uid)

    # 2) 見つからなければ email で既存ユーザーを探して紐付け（アカウント統合）
    if user.nil? && email.present?
      user = User.find_by(email: email)
      if user.present?
        user.update!(provider: provider, uid: uid)
      end
    end

    # 3) それでもいなければ新規作成
    if user.nil?
      user = User.new(provider: provider, uid: uid)
      user.email = email if user.email.blank?
      user.password = Devise.friendly_token[0, 20] if user.encrypted_password.blank?
    end

    # username を必須にしている場合、初期値を自動生成（衝突回避）
    if user.respond_to?(:username) && user.username.blank?
      base = auth.info.name.presence || email.split("@").first.presence || "user"
      base = base.to_s.gsub(/\s+/, "_").gsub(/[^0-9A-Za-z_\-]/, "")
      base = base.presence || "user"

      candidate = base.first(20)
      i = 1
      while User.where.not(id: user.id).exists?(username: candidate)
        i += 1
        suffix = "_#{i}"
        candidate = (base.first(20 - suffix.length) + suffix)
      end
      user.username = candidate
    end

    user.save! if user.changed?

    sign_in_and_redirect user, event: :authentication
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("[omniauth] google_oauth2 RecordInvalid: #{e.record.errors.full_messages.join(', ')}")
    redirect_to new_user_session_path, alert: "Googleログインに失敗しました: #{e.record.errors.full_messages.join(', ')}"
  rescue StandardError => e
    Rails.logger.error("[omniauth] google_oauth2 error: #{e.class} #{e.message}")
    Rails.logger.error(e.backtrace.take(30).join("\n"))
    redirect_to new_user_session_path, alert: "Googleログインに失敗しました（#{e.class}）"
  end

  def failure
    redirect_to root_path, alert: "認証に失敗しました"
  end
end
