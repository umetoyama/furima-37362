FactoryBot.define do
  factory :order_delivery_address do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    municipalities { '横浜市緑区' }
    address { '青山1-1-1' }
    building { '柳ビル' }
    phone_number { 1234567891 }
    # 07012345677
    item_id { 1 }
    token { 'acc_abcdefgooooo00000000000' }
  end
end
