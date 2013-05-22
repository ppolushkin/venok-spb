# coding: utf-8

class Notifier < ActionMailer::Base
  default :from => "sysadmin@venki-spb.ru"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_recieved.subject
  #
  def order_recieved(order)
    @order = order

    emails = []
    Admin.find_all_by_receive_emails(true).each do |a|
      emails << a.email
    end

    mail :to => emails, :subject => "venki-spb.ru Новый заказ"
  end
end
