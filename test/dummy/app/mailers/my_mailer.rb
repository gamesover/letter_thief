class MyMailer < ApplicationMailer
  def text_mail
    mail(from: Faker::Internet.email, to: Faker::Internet.email, subject: Faker::Lorem.sentence)
  end

  def html_mail
    mail(from: Faker::Internet.email, to: Faker::Internet.email, subject: Faker::Lorem.sentence)
  end

  def multipart_mail
    mail(from: Faker::Internet.email, to: Faker::Internet.email, subject: Faker::Lorem.sentence)
  end
end
