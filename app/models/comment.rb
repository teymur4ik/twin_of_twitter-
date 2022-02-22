class Comment < ApplicationRecord
  # принадлежит пользователю и посту
  belongs_to :user
  belongs_to :post
end
