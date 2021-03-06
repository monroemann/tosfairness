class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_loggings, dependent: :destroy
  has_many :contracts, through: :user_loggings

  validates :role, inclusion: { in: ['member', 'admin'] }

  def admin?
    role == "admin"
  end
end
