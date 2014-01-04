# coding: utf-8

module StoreHelper

  def show_extra_image_ref(product)
    if product.extra_image_name
      "<a href=\""+product.extra_image_name+"\">Фото без обработки&rarr;</a>"
    end
  end

  def product_full_name(product)
    product.name + ' (' + product.article + ')'
  end

  #todo: fix_obelisk
  def product_size(product)
    product.width.to_s + 'x' + product.height.to_s + " см"
  end

  def filter(param)
    if (param == "new")
      return " and created_at > '#{Date.today - 6.month}'"
    end
    if (param == "military")
      return " and may9 <> '0'"
    end
    if (param == "small")
      return " and height < '080'"
    end
    if (param == "middle")
      return " and height >= '080' and height < '100'"
    end
    if (param == "big")
      return " and height >= '100'"
    end
  end

  def sort(param)
    if param == nil
      return "price desc"
    else
      return "created_at desc"
    end
  end


end
