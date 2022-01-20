class Item < ApplicationRecord

  has_many :items
  has_one_attached :image

  

  with_options presence: true do
    validates :product_name
    validates :description
    validates :price
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :shipping_cost_id
    validates :prefecture_id
    validates :shipping_time_id
  end

end
