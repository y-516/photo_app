class ContactMailer < ApplicationMailer
  def contact_mail(picture)
      @picture = picture
      mail to: @picture.user.email,subject:"画像投稿完了の確認メール"
  end
end
