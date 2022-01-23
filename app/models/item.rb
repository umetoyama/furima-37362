class Item < ApplicationRecord

  belongs_to :user
  has_one_attached :image
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :prefecture
  belongs_to :shipping_cost
  belongs_to :shipping_time

  with_options presence: true do
    validates :product_name
    validates :description
  end

  validates :price, presence: true, numericality: { in: 300..9_999_999 }, format: { with: /\A[0-9]+\z/, message: "must be single-byte numbers only"}

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :shipping_cost_id
    validates :prefecture_id
    validates :shipping_time_id
  end

end
