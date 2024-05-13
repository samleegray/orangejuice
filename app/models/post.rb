class Post < ApplicationRecord
  belongs_to :discussion
  belongs_to :user
  validates :text, presence: true
end
