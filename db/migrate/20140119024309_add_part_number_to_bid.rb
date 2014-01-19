class AddPartNumberToBid < ActiveRecord::Migration
  def change
    add_column :bids, :sign_up, :string
  end
end
