class MyMailer < ApplicationMailer
  def text_mail
    mail(to: "rodi@hey.com", subject: "Text mail")
  end

  def html_mail
    mail(to: "rodi@hey.com", subject: "HTML mail")
  end

  def multipart_mail
    mail(to: "rodi@hey.com", subject: "Multipart mail")
  end
end
