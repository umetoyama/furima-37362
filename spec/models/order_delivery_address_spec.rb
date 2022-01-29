require 'rails_helper'

RSpec.describe OrderDeliveryAddress, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_delivery_address = FactoryBot.build(:order_delivery_address, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    context '内容に問題がない場合' do
      it '全ての値が正しければ保存できる' do
        expect(@order_delivery_address).to be_valid
      end
      it 'buildingは空でも保存できる' do
        @order_delivery_address.building = ''
        expect(@order_delivery_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できない' do
        @order_delivery_address.postal_code = ''
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できない' do
        @order_delivery_address.postal_code = '1234567'
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'prefecture_idが1だと保存できない' do
        @order_delivery_address.prefecture_id = 1
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'municipalitiesが空だと登録できない' do
        @order_delivery_address.municipalities = ''
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include("Municipalities can't be blank")
      end
      it 'addressが空だと登録できない' do
        @order_delivery_address.address = ''
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空だと登録できない' do
        @order_delivery_address.phone_number = ''
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが9文字以下の時保存できない' do
        @order_delivery_address.phone_number = 12_345
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include('Phone number must be between 10 and 11 single-byte numbers')
      end
      it 'phone_numberが12文字以上の時保存できない' do
        @order_delivery_address.phone_number = 123_456_789_123
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include('Phone number must be between 10 and 11 single-byte numbers')
      end
      it 'phone_numberに全角数字が含まれていると保存できない' do
        @order_delivery_address.phone_number = '０７０１２３４５６７７'
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include('Phone number is not a number')
      end
      it 'userが紐付いていないと登録できない' do
        @order_delivery_address.user_id = nil
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと登録できない' do
        @order_delivery_address.item_id = nil
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空だと登録できない' do
        @order_delivery_address.token = ''
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
