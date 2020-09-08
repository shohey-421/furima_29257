require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
      images = []
      images.push(fixture_file_upload('public/images/test_image.png'))
      @item.images = images
    end

    it 'name、、description、category_id、condition_id、shipping_burden_id、ship_from_id、shipping_date_id、price、imagesが存在すれば登録できること' do
      expect(@item).to be_valid
    end
    it 'nameが空では登録できないこと' do
      @item.name = nil
      @item.valid?
      expect(@item.errors.full_messages).to include '商品名を入力してください'
    end
    it 'descriptionが空では登録できないこと' do
      @item.description = nil
      @item.valid?
      expect(@item.errors.full_messages).to include '商品の説明を入力してください'
    end
    it 'category_idが空では登録できないこと' do
      @item.category_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include 'カテゴリーを選択してください'
    end
    it 'condition_idが空では登録できないこと' do
      @item.condition_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include '商品の状態を選択してください'
    end
    it 'shipping_burden_idが空では登録できないこと' do
      @item.shipping_burden_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include '配送料の負担を選択してください'
    end
    it 'ship_from_idが空では登録できないこと' do
      @item.ship_from_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include '発送元の地域を選択してください'
    end
    it 'shipping_date_idが空では登録できないこと' do
      @item.shipping_date_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include '発送までの日数を選択してください'
    end
    it 'priceが空では登録できないこと' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include '販売価格を入力してください'
    end
    it 'imageが空では登録できないこと' do
      @item.images = nil
      @item.valid?
      expect(@item.errors.full_messages).to include '画像は必須です'
    end

    it 'category_idが0では登録できないこと' do
      @item.category_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include 'カテゴリーを選択してください'
    end
    it 'condition_idが0では登録できないこと' do
      @item.condition_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include '商品の状態を選択してください'
    end
    it 'shipping_burden_idが0では登録できないこと' do
      @item.shipping_burden_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include '配送料の負担を選択してください'
    end
    it 'ship_from_idが0では登録できないこと' do
      @item.ship_from_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include '発送元の地域を選択してください'
    end
    it 'shipping_date_idが0では登録できないこと' do
      @item.shipping_date_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include '発送までの日数を選択してください'
    end

    it 'priceが半角数字以外では登録できないこと' do
      @item.price = '３００'
      @item.valid?
      expect(@item.errors.full_messages).to include '販売価格は半角数字で入力してください'
    end

    it 'priceが299以下では登録できないこと' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include '販売価格は¥300〜9,999,999で入力してください'
    end
    it 'priceが10000000以上では登録できないこと' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include '販売価格は¥300〜9,999,999で入力してください'
    end
  end
end
