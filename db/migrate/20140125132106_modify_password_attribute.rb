class ModifyPasswordAttribute < ActiveRecord::Migration
  def change
    rename_column :users, :password_confirm, :password_confirmation
  end
end
