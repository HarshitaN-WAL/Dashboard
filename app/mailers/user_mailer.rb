class UserMailer < ApplicationMailer
  default from: 'PMTOOL'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000'
    attachments['welcome.jpg'] = File.read('app/assets/images/welcome.jpg')
    mail(to: @user.email, subject: 'Welcome to PM Tool')
  end
end
