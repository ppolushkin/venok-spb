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

  def product_size(product)
    product.width + 'x' + product.height + " см"
  end

end
