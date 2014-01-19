class CreatePriceCounts < ActiveRecord::Migration
  def change
    create_table :price_counts do |t|
      t.string :user_name
      t.string :activity_name
      t.string :bid_name
      t.string :price
      t.string :number

      t.timestamps
    end
  end
end
