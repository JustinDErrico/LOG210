class UserMailer < ActionMailer::Base
  default :from => 'default@myapp.com'

  def registration_confirmation(user)
    mail(:to => user.emailAddress, :subject => "Order registered")
  end
end