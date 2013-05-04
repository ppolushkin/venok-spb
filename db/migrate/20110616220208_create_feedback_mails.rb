class CreateFeedbackMails < ActiveRecord::Migration
  def self.up
    create_table :feedback_mails do |t|
      t.string :email
      t.string :name
      t.string :phone
      t.text :message

      t.timestamps
    end
  end

  def self.down
    drop_table :feedback_mails
  end
end
