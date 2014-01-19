class CreateBidLists < ActiveRecord::Migration
  def change
    create_table :bid_lists do |t|
      t.string :user_name
      t.string :activity_name
      t.string :bid_name
      t.string :name
      t.string :price
      t.string :phone

      t.timestamps
    end
  end
end
