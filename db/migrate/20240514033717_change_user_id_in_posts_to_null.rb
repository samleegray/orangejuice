# frozen_string_literal: true

class ChangeUserIdInPostsToNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :posts, :user_id, true
    change_column_null :discussions, :user_id, true
  end
end
