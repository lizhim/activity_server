class CreateWinners < ActiveRecord::Migration
  def change
    create_table :winners do |t|
      t.string :user_name
      t.string :activity_name
      t.string :bid_name
      t.string :name
      t.string :phone
      t.string :price

      t.timestamps
    end
  end
end
