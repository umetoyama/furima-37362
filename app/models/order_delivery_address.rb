class OrderDeliveryAddress
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :postal_code, :prefecture_id, :municipalities, :address, :building, :phone_number

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフンを含む適当な数列で入力して下さい' }
    validates :municipalities
    validates :address
    validates :phone_number, numericality: { only_integer: true },
                             length: { minimum: 10, maximum: 11, message: 'は10~11桁の半角数字のみです' }
    validates :token
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "を入力して下さい" }

  def storage
    order = Order.create(user_id: user_id, item_id: item_id)
    DeliveryAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, municipalities: municipalities,
                           address: address, building: building, phone_number: phone_number, order_id: order.id)
  end
end
