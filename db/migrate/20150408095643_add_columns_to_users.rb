class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :user_name, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :role_id, :integer
    add_column :users, :sign_up_count, :integer
    add_column :users, :batch_id, :integer
  end
end
