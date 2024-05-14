class User < ApplicationRecord
  belongs_to :role, optional: true
  has_many :posts
  has_many :discussions
  validates_uniqueness_of :username
  # Include default users modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_destroy :nullify_associations

  def admin?
    return unless role

    role.name == 'admin'
  end

  private

  def nullify_associations
    posts.update_all(user_id: nil)
    discussions.update_all(user_id: nil)
  end
end
