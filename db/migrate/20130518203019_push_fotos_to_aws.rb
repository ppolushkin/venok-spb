class PushFotosToAws < ActiveRecord::Migration

  def up
    Rake::Task['foto:push_to_s3'].invoke
  end

  def down
    puts "nothing to do"
  end

end
