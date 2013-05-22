# coding: utf-8

class NewOrderNotification < ActionMailer::Base
  default :from => "sysadmin@venki-spb.ru"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.feedback.send.subject
  #
  def send_mail_now(sender_mail, sender_name, sender_phone, msg)
    @sender_mail = sender_mail
    @sender_name = sender_name
    @sender_phone = sender_phone
    @feedback_msg = msg

    emails = []
    Admin.find_all_by_receive_emails(true).each do |a|
      emails << a.email
    end

    mail :to => emails, :subject => "Новый заказ"
  end
end
