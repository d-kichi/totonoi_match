class ContactMailer < ApplicationMailer
  default to: 'd.hatake1217@gmail.com' # 運営側（受信先）

  def send_contact(contact)
    @contact = contact
    mail(
      from: @contact.email,
      subject: "【ととのいmatch!!】お問い合わせが届きました"
    )
  end
end
