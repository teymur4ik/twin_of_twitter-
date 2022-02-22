class User < ApplicationRecord
  # отвечает за хэширование пароля
  # аналогично post.rb
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :name, length: { minimum: 3 }
  validates :name, uniqueness: true
end
