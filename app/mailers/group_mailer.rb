class GroupMailer < ActionMailer::Base
  default from: "gurupu.dev@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.group_mailer.invite.subject
  #
  def invite(invitation)
    @invitation = invitation
    mail(to: invitation.email, subject: "#{invitation.user.name} invite you to join GURUPU")
  end
end
