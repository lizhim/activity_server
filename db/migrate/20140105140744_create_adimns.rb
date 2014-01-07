class CreateAdimns < ActiveRecord::Migration
  def change
    create_table :adimns do |t|
      t.string :name
      t.string :password
      t.string :password_confirm

      t.timestamps
    end
  end
end
