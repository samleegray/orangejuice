class AddDiscussionToPosts < ActiveRecord::Migration[7.1]
  def up
    add_reference :posts, :discussion, null: false, foreign_key: true
  end

  def down
    remove_reference :posts, :discussion, null: false, foreign_key: true
  end
end
