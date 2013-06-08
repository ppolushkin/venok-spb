class ConvertProductSize < ActiveRecord::Migration
  def up
    change_table :products do |t|
      t.change :height, :integer
      t.change :width, :integer
    end
  end

  def down
    change_table :products do |t|
      t.change :height, :string
      t.change :width, :string
    end
  end
end
