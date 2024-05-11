class Discussion < ApplicationRecord
  has_many :posts, dependent: :destroy
end
