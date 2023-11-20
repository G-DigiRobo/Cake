class Item < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true

  belongs_to :genre
  has_one_attached :image

  enum is_sales_status: {
    "販売中":0, "販売停止中":1
  }

  def get_profile_image(width, height)
  unless image.attached?
    file_path = Rails.root.join('app/assets/images/cake_b.png')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
    image.variant(resize_to_limit: [width, height]).processed
  end
end
