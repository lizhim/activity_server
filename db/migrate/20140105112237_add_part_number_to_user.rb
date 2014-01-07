class AddPartNumberToUser < ActiveRecord::Migration
  def change
    add_column :users, :password_confirm, :string
    add_column :users, :question, :string
    add_column :users, :answer, :string
    add_column :users, :admin, :string
  end
end
