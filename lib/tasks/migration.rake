namespace :migration do

  desc "pushing fotos to Amazon S3"
  task :populate_retail_price => :environment do

    products = Product.all(:conditions => "id > 1", :order => "id")
    products.each() do |p|
      print "\npopulate retail price for " + p.id.to_s + "..."
      Product.transaction do
        begin
          p.retail_price=p.price * 2
          p.save!
        rescue
          print "Error"
        end
      end
    end
  end


end