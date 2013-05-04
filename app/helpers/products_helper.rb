# coding: utf-8

module ProductsHelper

  def commit_tmp_uploaded_images(article)
    if (File.exist?(absolute_foto_path(get_tmp_image_name(article, 's'))))
      File.rename(absolute_foto_path(get_tmp_image_name(article, 's')), absolute_foto_path(get_image_name(article, 's')))
    end
    if (File.exist?(absolute_foto_path(get_tmp_image_name(article, 'b'))))
      File.rename(absolute_foto_path(get_tmp_image_name(article, 'b')), absolute_foto_path(get_image_name(article, 'b')))
    end
    if (File.exist?(absolute_foto_path(get_tmp_image_name(article, 'e'))))
      File.rename(absolute_foto_path(get_tmp_image_name(article, 'e')), absolute_foto_path(get_image_name(article, 'e')))
    end
  end

  def get_tmp_image_names(article)
    [get_tmp_image_name(article, 's'), get_tmp_image_name(article, 'b'), get_tmp_image_name(article, 'e')]
  end

  def get_image_names(article)
    [get_image_name(article, 's'), get_image_name(article, 'b'), get_image_name(article, 'e')]
  end

  def get_image_name(article, image_prefix)
    get_image_name_parametrized(article.to_s, image_prefix, false)
  end

  def get_tmp_image_name(article, image_prefix)
    get_image_name_parametrized(article.to_s, image_prefix, true)
  end

  def upload_tmp_images_from_hash_and_fix_hash(product_params)
    upload_tmp_small_image product_params
    upload_tmp_big_image product_params
    upload_tmp_extra_image product_params
  end

  def upload_tmp_small_image(product_params)
    upload_file(product_params, :small_image_name)
  end

  def upload_tmp_big_image(product_params)
    upload_file(product_params, :big_image_name)
  end

  def upload_tmp_extra_image(product_params)
    upload_file(product_params, :extra_image_name)
  end

  def delete_uploaded_images(article)
    get_image_names(article).each do |image_name|
      file_name = absolute_foto_path image_name
      File.delete(file_name) if File.exist?(file_name)
    end
  end

  def delete_tmp_uploaded_images(article)
    get_tmp_image_names(article).each do |image_name|
      file_name = absolute_foto_path image_name
      File.delete(file_name) if File.exist?(file_name)
    end
  end

  def absolute_foto_path(image_path)
    Dir.pwd + '/public' + image_path
  end

  private

  def upload_file(product_request_parameters_hash, image_property_key)
    if (product_request_parameters_hash.include?(image_property_key))
      tmp_image_name = get_tmp_image_name(product_request_parameters_hash[:article], image_property_key.to_s[0].chr)

      File.open(absolute_foto_path(tmp_image_name), "wb") do |f|
        f.write(product_request_parameters_hash[image_property_key].read)
      end

      image_name = get_image_name(product_request_parameters_hash[:article], image_property_key.to_s[0].chr)
      product_request_parameters_hash[image_property_key] = image_name
    end
  end

  def get_image_name_parametrized(article, image_prefix, tmp)
    image_name = article.sub('В', 'V')
    image_name = image_name.sub('К', 'Q')
    image_name = image_name.sub('Ф', 'F')
    if(tmp)
      '/images/foto/tmp-' + image_name + '-' + image_prefix + '.jpg'
    else
      '/images/foto/' + image_name + '-' + image_prefix + '.jpg'
    end
  end  

end
