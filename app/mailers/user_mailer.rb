class UserMailer < ActionMailer::Base
  default :from => 'default@myapp.com'
  add_template_helper(ApplicationHelper)

  def registration_confirmation(user, commande_id, no_confirmation)
    @commande_id = commande_id
    mail(:to => user.emailAddress, :subject => "Order registered: " + no_confirmation)
  end
end