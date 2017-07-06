class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post

    validates :comments, presence: true
end