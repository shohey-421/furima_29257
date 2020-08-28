require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '#create' do
    before do
      @order_address = FactoryBot.build(:order_address)
    end
    
    it "token、postcode、region_id、city、block、phone_numberが存在すれば登録できること" do
      expect(@order_address).to be_valid
    end
    
    it "tokenが空では登録できないこと" do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end
    
    it "postcodeが空では登録できないこと" do
      @order_address.postcode = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postcode can't be blank")
    end
    it "postcodeが-（ハイフン）無しでは登録できないこと" do
      @order_address.postcode = "1234567"
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postcode Include hyphen(-)")
    end

    it "region_idが空では登録できないこと" do
      @order_address.region_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Region can't be blank")
    end

    it "cityが空では登録できないこと" do
      @order_address.city = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank")
    end

    it "blockが空では登録できないこと" do
      @order_address.block = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Block can't be blank")
    end

    it "phone_numberが空では登録できないこと" do
      @order_address.phone_number = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
    end
  end
end
