class User < ApplicationRecord
  belongs_to :role
  has_many :posts
  has_many :discussions
  # Include default users modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def is_admin?
    return unless role

    role.name == 'admin'
    
  end
end
