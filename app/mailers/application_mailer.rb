class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.sendgrid[:domain]
  layout 'mailer'
end
