class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :recipes
  has_many :meal_plans
  has_many :bookmarks
  has_many :reviews

  def has_bookmarked?(recipe)
    bookmarks.where(recipe: recipe).exists?
  end
end
