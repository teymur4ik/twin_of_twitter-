class Post < ApplicationRecord
  # принадлежит пользователю; имеет комменты и лайки, может их удалять
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  # титул должен состоять минимум из 5 символов
  validates :title, length: { minimum: 5 }
end
