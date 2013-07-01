# coding: utf-8

class Product < ActiveRecord::Base

  validates :article, :name, :small_img, :medium_img, :price, :presence => true
  validates :article, :uniqueness => true

  validates :article, :format => {
      :with    => /[ВКФИЦ]\d+/,
      :message => "Артикль должен иметь формат В{номер} - для венка, К{номер} - для корзины или Ф{номер} - для фона, И{номер} - для изделия, Ц{номер} - для цветов"
  }
  validates :article, :format => {
      :without => /(.+[ВКФИЦ]\d+)|([ВКФ]\d+\D+)/,
      :message => "Артикль должен иметь формат В{номер} - для венка, К{номер} - для корзины или Ф{номер} - для фона, И{номер} - для изделия, Ц{номер} - для цветов"
  }
  validates_numericality_of :height, :width, :price, :greater_than => 0

  validates :height, :width, :length => { :minimum => 3 }

  mount_uploader :small_img, SmallFotoUploader
  mount_uploader :medium_img, MediumFotoUploader
  mount_uploader :big_img, FotoUploader

  has_many :basket_items, :dependent => :destroy
  has_many :depot_items, :dependent => :destroy

  def venok?
    article.force_encoding('UTF-8').include?("В")
  end

  def korzina?
    article.force_encoding('UTF-8').include?("К")
  end

  def izdelie?
    article.force_encoding('UTF-8').include?("И")
  end

  def flower?
    article.force_encoding('UTF-8').include?("Ц")
  end


  def formatted_retail_price
    sprintf("%u р", self.retail_price)
  end

  def link
    return '/venok/' + id.to_s if venok?
    return '/korzina/' + id.to_s if korzina?
    return '/izdelie/' + id.to_s if izdelie?
    return '/flower/' + id.to_s if flower?
  end

end
