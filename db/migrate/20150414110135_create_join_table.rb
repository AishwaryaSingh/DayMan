class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :roles, :users do |t|
    	
        t.references :role, :user
      # t.index [:role_id, :user_id]
      # t.index [:user_id, :role_id]
        end
        add_index(:roles_users, [:role_id, :user_id], :unique => true)
    end
end
