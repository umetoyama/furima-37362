class OrderDeliveryAddress
  
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :municipalities, :address, :building, :phone_number, :order_id

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :municipalities
    validates :address
    validates :phone_number, numericality: true, length: { minimum: 10, maximum: 11 }
    validates :order_id
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    DliveryAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, municipalities: municipalities, address: address, building: building, phone_number: phone_number, order_id: order.id)
  end

end