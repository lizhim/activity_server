class AddStatusToBidList < ActiveRecord::Migration
  def change
    add_column :bid_lists, :bid_status, :string
  end
end
