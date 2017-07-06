class Post < ApplicationRecord
    mount_uploaders :images, ImagesUploader
    belongs_to :user
    has_many :comments
    has_many :likes
    has_many :buyings

    validates_presence_of :images
    validates_presence_of :price
end