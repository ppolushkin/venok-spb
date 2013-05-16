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

  validates :application_name, :presence => true

  before_create :setup_application_name
  before_update :verify_application_name
  before_destroy :verify_application_name
  after_find :verify_application_name

  private

  def setup_application_name()
    self.application_name=APPLICATION_NAME
  end

  def verify_application_name()
    unless self.application_name == APPLICATION_NAME
      raise "Permission denied to message " + self.id
    end
  end

end
