namespace :session_cleaner do

  desc "Clears old not committed baskets"
  task :clean => [:environment] do
    Basket.all.each() do |b|
      if b.created_at < (DateTime.now - 1.day)
        b.destroy
      end
    end
  end

end