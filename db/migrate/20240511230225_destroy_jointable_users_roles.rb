class DestroyJointableUsersRoles < ActiveRecord::Migration[7.1]
  def change
    drop_join_table :users, :roles do |t|
      t.index :user_id
      t.index :role_id
      # t.index [:user_id, :role_id]
      # t.index [:role_id, :user_id]
    end
  end
end
