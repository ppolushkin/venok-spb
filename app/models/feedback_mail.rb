# coding: utf-8

class FeedbackMail < ActiveRecord::Base

  validates :email, :format => {
      :with => /.+/,
      :message => "Ваш почтовый ящик не указан "
  }

  validates :email, :format => {
      :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/,
      :message => "Почтовый адрес введен неверно"
  }

  validates :name, :format => {
      :with => /.+/,
      :message => "Ваше имя не указано "
  }

  validates :message, :format => {
      :with => /.+/,
      :message => "Сообщение пустое"
  }

end
