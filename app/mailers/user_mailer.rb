class UserMailer < ApplicationMailer
  def send_report_card(email)
    @user = User.find_by(email: email)
    @url = 'http://localhost:3000/users'
    mail(to: @user.email, subject: 'Your Weekly Report Card')
  end
end
