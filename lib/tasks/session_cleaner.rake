namespace :session_cleaner do

  desc "Clears old not committed baskets"
  task :clean => [:environment] do
    removed = 0
    Basket.all.each() do |b|
      if b.created_at < (DateTime.now - 1.day)
        removed = removed + 1
        b.destroy
      end
      puts "Removed: #{removed} old basket objects"
    end
  end

end