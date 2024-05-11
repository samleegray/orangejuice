class RemoveRolesToUsers < ActiveRecord::Migration[7.1]
  def change
    remove_reference :roles, :user, null: true, foreign_key: true
    remove_reference :users, :role, null: true, foreign_key: true
  end
end
