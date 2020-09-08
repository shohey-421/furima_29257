require 'rails_helper'

RSpec.describe "商品出品", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
  end

  context '商品出品ができないとき' do
    it '誤った情報では商品出品ができず、再び商品出品ページへ戻ってくる' do
      # サインインする
      sign_in(@user)
      # 商品出品ページへ移動する
      visit  new_item_path
      # 必須事項を入力せず出品するボタンを押しても、アイテムモデルのカウントが上がらないことを確認する
      expect{find('input[name="commit"]').click}.to change { Item.count }.by(0)
      # 商品出品ページへ戻ってくる
      expect(current_path).to eq "/items"
    end
  end

  context '商品出品ができるとき' do
    it '商品出品が成功するとトップページに遷移し、出品した商品が表示されている' do
      # サインインする
      sign_in(@user)
      # 商品出品ページへ移動する
      visit  new_item_path
      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')
      # 画像選択フォームに画像を添付する
      attach_file('item[images][]', image_path)
      # 商品情報を入力する
      fill_in "item-name", with: @item.name
      fill_in "item-info", with: @item.description
      select 'レディース', from:'item-category'
      select '新品、未使用', from:'item[condition_id]'
      select '着払い（購入者負担）', from:'item[shipping_burden_id]'
      select '北海道', from:'item[ship_from_id]'
      select '1〜2日で発送', from:'item[shipping_date_id]'
      fill_in "item-price", with: @item.price
      # 出品するボタンを押してもアイテムモデルのカウントが上がらないことを確認する
      expect{find('input[name="commit"]').click}.to change { Item.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
       # 送信した商品がブラウザに表示されていることを確認する
       expect(page).to have_content("#{@item.name}")
    end
  end
end

RSpec.describe "商品編集", type: :system do
  before do
    @item = FactoryBot.build(:item)
    images = []
    images.push(fixture_file_upload 'public/images/test_image.png') 
    @item.images = images
    @item.save
  end

  context '商品編集ができないとき' do
    it '商品編集に失敗し、再び商品編集ページに戻ってくる' do
      # サインインする
      sign_in(@item.user)
      # 商品詳細ページに遷移する
      visit  item_path(@item.id)
      # 商品の編集ボタンをクリックし、商品編集ページへ遷移する
      click_on "商品の編集"
      expect(current_path).to eq edit_item_path(@item.id)
      # 誤った商品情報を入力する
      fill_in 'item-name', with: ""
      # 変更するボタンをクリックする
      click_on("変更する")
      # 変更は反映されず商品情報編集ページに戻ってきていることを確認する
      expect(current_path).to eq item_path(@item.id)
    end
  end

  context '商品編集ができるとき' do
    it '商品編集に成功し、商品詳細ページに遷移する' do
      # サインインする
      sign_in(@item.user)
      # 商品詳細ページに遷移する
      visit  item_path(@item.id)
      # 商品の編集ボタンをクリックし、商品編集ページへ遷移する
      click_on "商品の編集"
      expect(current_path).to eq edit_item_path(@item.id)
      # 商品情報を変更する
      fill_in 'item-name', with: "編集後の商品名"
      # 変更するボタンをクリックする
      click_on("変更する")
      # 商品詳細ページへ遷移する
      expect(current_path).to eq item_path(@item.id)
      # 商品情報が編集されている事を確認する
      expect(page).to have_content("編集後の商品名")
    end
  end
end

RSpec.describe "商品削除", type: :system do
  before do
    @item = FactoryBot.build(:item)
    images = []
    images.push(fixture_file_upload 'public/images/test_image.png') 
    @item.images = images
    @item.save
  end

  it '商品を削除したとき、トップページへ遷移する' do
    # サインインする
    sign_in(@item.user)
    # 商品詳細ページに遷移する
    visit  item_path(@item.id)
    # 商品の削除ボタンをクリックし、アイテムモデルのカウントが１下がることを確認する
    expect{click_on "削除"}.to change{ Item.count }.by(-1)
    # 商品詳細ページへ遷移する
    expect(current_path).to eq root_path
    # トップページに削除した商品が表示されていない事を確認する
    expect(page).to have_no_content("#{@item.name}")
  end
end