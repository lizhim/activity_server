class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :user_name
      t.string :activity_name
      t.string :enrollment
      t.string :bidder

      t.timestamps
    end
  end
end
