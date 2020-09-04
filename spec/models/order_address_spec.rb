require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '#create' do
    before do
      @order_address = FactoryBot.build(:order_address)
    end

    it 'token、postcode、region_id、city、block、phone_numberが存在すれば登録できること' do
      expect(@order_address).to be_valid
    end

    it 'tokenが空では登録できないこと' do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("クレジットカード情報を正しく入力してください")
    end

    it 'postcodeが空では登録できないこと' do
      @order_address.postcode = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("郵便番号を入力してください")
    end
    it 'postcodeが-（ハイフン）無しでは登録できないこと' do
      @order_address.postcode = '1234567'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("郵便番号はハイフン(-)を含んでください")
    end

    it 'region_idが空では登録できないこと' do
      @order_address.region_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("都道府県を選択してください")
    end

    it 'cityが空では登録できないこと' do
      @order_address.city = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("市区町村を入力してください")
    end

    it 'blockが空では登録できないこと' do
      @order_address.block = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("番地を入力してください")
    end

    it 'phone_numberが空では登録できないこと' do
      @order_address.phone_number = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("電話番号を入力してください")
    end
    it 'phone_numberが12桁以上では登録できないこと' do
      @order_address.phone_number = '000000000000'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('電話番号は11文字以内で入力してください')
    end
  end
end
