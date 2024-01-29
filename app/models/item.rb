class Item < ApplicationRecord
has_one_attached :image

validate :image
validates :name, presence: true
validates :introduction, presence: true
validates :price, presence: true



def get_image(x,y)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [x, y]).processed
end

has_many :order_details, dependent: :destroy
has_many :cart_items, dependent: :destroy
end
