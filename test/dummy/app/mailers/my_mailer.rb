class MyMailer < ApplicationMailer
  default from: -> { Faker::Internet.email }

  def text_mail
    mail(to: Faker::Internet.email, subject: Faker::Lorem.sentence)
  end

  def html_mail
    mail(to: Faker::Internet.email, subject: Faker::Lorem.sentence)
  end

  def multipart_mail
    mail(to: Faker::Internet.email, subject: Faker::Lorem.sentence)
  end

  def attachments_mail
    attachments["sample.txt"] = {
      mime_type: "text/plain",
      content: "This is a plain text attachment"
    }

    image_data = File.read(Rails.root.join("app", "assets", "images", "fox.png"))
    attachments.inline["fox.png"] = {
      mime_type: "image/png",
      content: image_data
    }

    mail(to: Faker::Internet.email, subject: "Mail with attachments and inline image")
  end
end
