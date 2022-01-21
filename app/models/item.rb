class Item < ApplicationRecord

  has_many :items
  has_one_attached :image
  belongs_to :category
  belongs_to :condition
  belongs_to :prefecture
  belongs_to :shipping_cost
  belongs_to :shipping_time

  with_options presence: true do
    validates :product_name
    validates :description
    validates :price
  end

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :shipping_cost_id
    validates :prefecture_id
    validates :shipping_time_id
  end

end
