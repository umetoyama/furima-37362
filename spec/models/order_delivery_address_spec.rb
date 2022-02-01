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
        expect(@order_delivery_address.errors.full_messages).to include("郵便番号を入力してください", "郵便番号はハイフンを含む適当な数列で入力して下さい")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できない' do
        @order_delivery_address.postal_code = '1234567'
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include('郵便番号はハイフンを含む適当な数列で入力して下さい')
      end
      it 'prefecture_idが1だと保存できない' do
        @order_delivery_address.prefecture_id = 1
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include("都道府県を入力して下さい")
      end
      it 'municipalitiesが空だと登録できない' do
        @order_delivery_address.municipalities = ''
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'addressが空だと登録できない' do
        @order_delivery_address.address = ''
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include("番地を入力してください")
      end
      it 'phone_numberが空だと登録できない' do
        @order_delivery_address.phone_number = ''
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include("電話番号を入力してください", "電話番号は数値で入力してください", "電話番号は10~11桁の半角数字のみです")
      end
      it 'phone_numberが9文字以下の時保存できない' do
        @order_delivery_address.phone_number = 12_345
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include('電話番号は10~11桁の半角数字のみです')
      end
      it 'phone_numberが12文字以上の時保存できない' do
        @order_delivery_address.phone_number = 123_456_789_123
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include('電話番号は10~11桁の半角数字のみです')
      end
      it 'phone_numberに全角数字が含まれていると保存できない' do
        @order_delivery_address.phone_number = '０７０１２３４５６７７'
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include('電話番号は数値で入力してください')
      end
      it 'userが紐付いていないと登録できない' do
        @order_delivery_address.user_id = nil
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include("Userを入力してください")
      end
      it 'itemが紐付いていないと登録できない' do
        @order_delivery_address.item_id = nil
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include("Itemを入力してください")
      end
      it 'tokenが空だと登録できない' do
        @order_delivery_address.token = ''
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
    end
  end
end
