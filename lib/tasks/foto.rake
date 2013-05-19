namespace :foto do

  desc "Remove unused fotos and fix database if there is no linked foto"
  task :fix  do

  end

  desc "Remove unused fotos. Unused means there is no reference from products table"
  task :remove_unused, [:force] => :environment do |t, args|
    puts "Removing unused fotos from " + ENV["FOTO_DIR"] + " directory...\n"

    products            = Product.all
    existing_foto_names = Dir.glob(ENV["FOTO_DIR"] + "*.*").to_a

    products.each() do |product|
      if product.small_image_name
        existing_foto_names.delete(product.small_image_path)
      end
      if product.big_image_name
        existing_foto_names.delete(product.big_image_path)
      end
      if product.extra_image_name
        existing_foto_names.delete(product.extra_image_path)
      end
    end

    if existing_foto_names.empty?
      puts "No files should be removed \n"
    else
      puts "Found " + existing_foto_names.size.to_s + " unused fotos: \n"

      existing_foto_names.each() do |f|
        puts f + "\n"
        if args[:force] == "FORCE"
          File.delete(f)
        end
      end
    end

  end

  desc "Fix database if foto absent"
  task :fix_db => [:environment] do
    Product.all.each do |p|
      #todo
    end
  end

  desc "Rename jpb -> jpg"
  task :fix_jpb => [:environment] do
    Product.all.each do |p|
      p.small_image_name = p.small_image_name.gsub('jpb', 'jpg')
      p.big_image_name = p.big_image_name.gsub('jpb', 'jpg')
      p.extra_image_name = p.extra_image_name.gsub('jpb', 'jpg')
      p.save
    end
  end

  desc "pushing fotos to Amazon S3"
  task :push_to_s3, [:force] => :environment do |t, args|
    raise "setup FOTO_DIR environment variable" unless ENV["FOTO_DIR"]

    products = Product.all(:conditions => "id > 1", :order => "id")

    products.each() do |p|

      print "\npushing " + p.id.to_s + "..."

      next unless p.small_image_name && p.big_image_name

      small_img_file = ENV["FOTO_DIR"] + p.small_image_name
      medium_img_file = ENV["FOTO_DIR"] + p.big_image_name
      big_img_file = ENV["FOTO_DIR"] + p.extra_image_name

      Product.transaction do

        begin
          if File.exist?(small_img_file)
            p.small_img = File.open(small_img_file)
            print " S"
          end

          if File.exist?(medium_img_file)
            p.medium_img = File.open(medium_img_file)
            print "-M"
          end

          if File.exist?(big_img_file)
            p.big_img = File.open(big_img_file)
            print "-B"
          end
          p.save!
        rescue
          print "Error"
        end
      end
    end
  end



end