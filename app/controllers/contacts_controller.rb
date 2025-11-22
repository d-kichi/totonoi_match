class ContactsController < ApplicationController
  def new
    @contact = ContactForm.new
  end

  def create
    @contact = ContactForm.new(contact_params)
    if @contact.valid?
      ContactMailer.send_contact(@contact).deliver_now
      redirect_to thanks_contacts_path, notice: "お問い合わせを送信しました。ありがとうございます！"
    else
      flash.now[:alert] = "入力内容に誤りがあります。"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact_form).permit(:name, :email, :message)
  end
end
