class Product < ApplicationRecord

  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :price, numericality:{greater_than: 0}

end
