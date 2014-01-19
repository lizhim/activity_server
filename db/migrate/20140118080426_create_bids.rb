class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.string :user_name
      t.string :activity_name
      t.string :bid_name
      t.string :bid_number

      t.timestamps
    end
  end
end
