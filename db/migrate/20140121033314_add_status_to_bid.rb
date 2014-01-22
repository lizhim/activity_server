class AddStatusToBid < ActiveRecord::Migration
  def change
    add_column :bids, :bid_status, :string
  end
end
