require 'rails_helper'

RSpec.describe "商品購入", type: :system do
  before do
    @item = FactoryBot.build(:item)
    images = []
    images.push(fixture_file_upload 'public/images/test_image.png') 
    @item.images = images
    @item.save
    @order_address = FactoryBot.build(:order_address)
  end

  # 商品購入時にテーブルにデータが保存されるまで待機
  def wait_condition(interval: 0.5, limit: 10, &condition)
    start_at = Time.now
    raise "must give block!" unless block_given?
    while !condition.call do
      sleep interval
      break puts("time out") if (Time.now - start_at) > limit
    end
  end

  context '商品購入ができないとき' do
    it '商品購入に失敗したとき、再び商品購入ページに戻る' do
      # 商品購入ユーザーを作成する
      @user = FactoryBot.create(:user)
      # 商品購入ユーザーでサインインする
      sign_in(@user)
      # 商品詳細ページに遷移する
      visit  item_path(@item.id)
      # 購入画面に進むボタンをクリックし、商品購入ページに遷移する
      click_on "購入画面に進む"
      expect(current_path).to eq item_orders_path(@item.id)
      # 必須事項を入力せず購入ボタンを押してもオーダーモデルのカウントが上がらないことを確認する
      expect{find('input[name="commit"]').click}.to change { Order.count }.by(0)
      # 商品購入ページに戻る
      expect(current_path).to eq item_orders_path(@item.id)
    end
  end

  context '商品購入ができるとき' do
    it '商品購入に成功したとき、トップページに戻り、購入した商品にSoldOut!!の表示がされる' do
      # 商品購入ユーザーを作成する
      @user = FactoryBot.create(:user)
      # 商品購入ユーザーでサインインする
      sign_in(@user)
      # トップページの商品にSold Out!!の表示がない事を確認する
      expect(page).to have_no_content("Sold Out!!")
      # 商品詳細ページに遷移する
      visit  item_path(@item.id)
      # 購入画面に進むボタンをクリックし、商品購入ページに遷移する
      click_on "購入画面に進む"
      expect(current_path).to eq item_orders_path(@item.id)
      # 必須事項を入力し購入ボタンをクリックする
      fill_in "card-number", with: "4242424242424242"
      fill_in "card-exp-month", with: "3"
      fill_in "card-exp-year", with: "24"
      fill_in "card-cvc", with: "123"
      fill_in "postal-code", with: @order_address.postcode
      select '北海道', from:'order_address[region_id]'
      fill_in "city", with: @order_address.city
      fill_in "addresses", with:@order_address.block
      fill_in "phone-number", with:@order_address.phone_number
      find('input[name="commit"]').click
      # テーブルにデータが保存されるまで待機
      wait_condition { !Order.count.zero? }
      # トップページに戻っている事を確認
      expect(current_path).to eq root_path      
      # 購入した商品にSold Out!!と表示される
      expect(page).to have_content("Sold Out!!")
    end
  end
end