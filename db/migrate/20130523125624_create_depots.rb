# coding: utf-8

class CreateDepots < ActiveRecord::Migration
  def up
    create_table :depots do |t|
      t.string :name, :null=>false

      t.timestamps
    end

    Depot.create(:name => 'Склад')
  end

  def down
    drop_table :depots
  end


end
