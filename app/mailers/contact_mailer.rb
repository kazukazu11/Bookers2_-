class ContactMailer < ApplicationMailer
	def send_when_admin_reply(user) #メソッドに対して引数を設定
    	@user = user
    	mail to: user.email, subject:"新規登録完了のご連絡"
	end
end
