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

  def show_link(product)
    return '/venok/' + product.id.to_s if product.venok?
    return '/korzina/' + product.id.to_s if product.korzina?
    return '/izdelie/' + product.id.to_s if product.izdelie?
  end

end
