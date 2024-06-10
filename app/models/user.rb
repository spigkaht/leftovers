class User < ApplicationRecord
  has_many :favourites, dependent: :destroy
  has_many :recipes, through: :favourites
  has_many :user_ingredients, dependent: :destroy
  has_many :ingredients, through: :user_ingredients

  validates :first_name, :last_name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
