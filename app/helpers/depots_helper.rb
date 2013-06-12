# coding: utf-8

module DepotsHelper

  #рит/ венок "Акварель" 3.2.3
  #рит/ венок 'Акварель' 3.2.3
  #рит "Акварель"
  #"Акварель" 3.1.2
  #рит 'Акварель'
  #'Акварель' 3.2.1
  #"Акварель"
  #'Акварель'
  #Акварель
  #В151
  def self.find_product_by_name(name)
    for i in 0..2
      pn = parce_name(name, i)
      p = Product.where("lower(name) =?", pn.downcase).first if pn
      return p if p
    end

    for i in 0..2
      pn = parce_name(name, i)
      p = Product.where("lower(article) =?", pn.downcase).first if pn
      return p if p
    end

    nil
  end

  def self.parce_name(name, attempt)
    return name.split('"')[1] if attempt == 0;
    return name.split("'")[1] if attempt == 1;
    return name if attempt == 2;
  end

  def self.find_product_by_article(article)
      Product.find_by_article article
  end


end
