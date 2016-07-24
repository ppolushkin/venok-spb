class MakeLongDescription < ActiveRecord::Migration

  def up
    change_column :products, :notes, :string, :limit => 600
  end

  def down
    change_column :products, :notes, :string, :limit => 255
  end
end
