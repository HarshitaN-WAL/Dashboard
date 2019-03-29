# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'KTOOL'

  def welcome_email(user:, password:)
    @user = user
    @password = password
    byebug
    @url  = 'http://localhost:3000'
    attachments['welcome.jpg'] = File.read('app/assets/images/welcome.jpg')
    mail(to: @user.email, subject: 'Welcome to KTool')
  end
end
