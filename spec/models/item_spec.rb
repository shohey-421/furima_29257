require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload 'public/images/test_image.png'
    end

    it 'name、、description、category_id、condition_id、shipping_burden_id、ship_from_id、shipping_date_id、price、imageが存在すれば登録できること' do
      expect(@item).to be_valid
    end
    it 'nameが空では登録できないこと' do
      @item.name = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Name can't be blank"
    end
    it 'descriptionが空では登録できないこと' do
      @item.description = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Description can't be blank"
    end
    it 'category_idが空では登録できないこと' do
      @item.category_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Category can't be blank"
    end
    it 'condition_idが空では登録できないこと' do
      @item.condition_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Condition can't be blank"
    end
    it 'shipping_burden_idが空では登録できないこと' do
      @item.shipping_burden_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Shipping burden can't be blank"
    end
    it 'ship_from_idが空では登録できないこと' do
      @item.ship_from_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Ship from can't be blank"
    end
    it 'shipping_date_idが空では登録できないこと' do
      @item.shipping_date_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Shipping date can't be blank"
    end
    it 'priceが空では登録できないこと' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Price can't be blank"
    end
    it 'imageが空では登録できないこと' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Image can't be blank"
    end

    it 'category_idが0では登録できないこと' do
      @item.category_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include 'Category Select'
    end
    it 'condition_idが0では登録できないこと' do
      @item.condition_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include 'Condition Select'
    end
    it 'shipping_burden_idが0では登録できないこと' do
      @item.shipping_burden_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include 'Shipping burden Select'
    end
    it 'ship_from_idが0では登録できないこと' do
      @item.ship_from_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include 'Ship from Select'
    end
    it 'shipping_date_idが0では登録できないこと' do
      @item.shipping_date_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include 'Shipping date Select'
    end

    it 'priceが半角数字以外では登録できないこと' do
      @item.price = '３００'
      @item.valid?
      expect(@item.errors.full_messages).to include 'Price Half-width number'
    end

    it 'priceが299以下では登録できないこと' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include 'Price Out of setting range'
    end
    it 'priceが10000000以上では登録できないこと' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include 'Price Out of setting range'
    end
  end
end
