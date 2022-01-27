class Order < ApplicationRecordo
  
    validates :item_id, presence: true

    belongs_to :user
    belongs_to :item
    has_one :delivery_addresses

end
