class User < ApplicationRecord
  belongs_to :role, optional: true
  has_many :posts
  has_many :discussions
  validates_uniqueness_of :username
  # Include default users modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    return unless role

    role.name == 'admin'
  end
end
