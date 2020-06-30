class DailyMailer < ApplicationMailer
	def send_mail
    mail(bcc: User.pluck(:email), subject:"ご連絡")
  end
end
