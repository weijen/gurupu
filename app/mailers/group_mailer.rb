class GroupMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.group_mailer.invite.subject
  #
  def invite(user, group, mailto)
    @user = user
    @group = group
    mail(to: mailto, subject:'user.name invite you! Join GURUPU')
  end
end
