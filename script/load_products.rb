# In order to use it:
#~/RoR/obelisk$ rails runner script/load_products.rb

Product.transaction do
  (1..100).each do |i|
    Product.create(:article          => "В#{i}",
                   :name             => "Защитник #{i}",
                   :height           => "70",
                   :width            => "120",
                   :notes            =>
                       %{Серию венков "Защитникам Отечества". Уникальность ритуальных венков в их щитообразной форме, подчеркнутой золотой фурнитурой и "заклепками" по контуру },
                   :small_image_name => '/images/foto/V332-s.jpg',
                   :big_image_name   => '/images/foto/V332-b.jpg',
                   :price            => 980)
  end

  (1..100).each do |i|
    Product.create(:article          => "К#{i}",
                   :name             => "Корзина #{i}",
                   :height           => "70",
                   :width            => "120",
                   :notes            =>
                       %{Серию венков "Защитникам Отечества". Уникальность ритуальных венков в их щитообразной форме, подчеркнутой золотой фурнитурой и "заклепками" по контуру },
                   :small_image_name => '/images/foto/V332-s.jpg',
                   :big_image_name   => '/images/foto/V332-b.jpg',
                   :price            => 980)
  end

  (1..100).each do |i|
    Product.create(:article          => "Ф#{i}",
                   :name             => "Фон #{i}",
                   :height           => "70",
                   :width            => "120",
                   :notes            =>
                       %{Серию венков "Защитникам Отечества". Уникальность ритуальных венков в их щитообразной форме, подчеркнутой золотой фурнитурой и "заклепками" по контуру },
                   :small_image_name => '/images/foto/V332-s.jpg',
                   :big_image_name   => '/images/foto/V332-b.jpg',
                   :price            => 980)
  end

end

