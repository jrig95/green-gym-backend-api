class ApplicationMailer < ActionMailer::Base
  # default from: 'admin@admin.com'
  # for letter opener in development

  default from: 'sean01@dtd-edu.cn'
  # using sean's postmark account for testing in production

  # default from: 'darren@relabs.co'
  # for the live website, and after this postmark account is setup and verified

  layout 'mailer'
end
