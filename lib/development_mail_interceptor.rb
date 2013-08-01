class DevelopmentMailInterceptor  
  def self.delivering_email(message)  
    message.subject = "to:#{message.to} bcc:#{message.bcc} #{message.subject}"  
    recipient = Setting.smtp_setting.recipient
    message.to = recipient if message.to
    message.bcc = recipient if message.bcc
  end  
end  
