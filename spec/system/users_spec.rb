require 'rails_helper'

RSpec.describe "新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context '新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに遷移する
      visit  root_path
      # トップページにあるサインアップページへ遷移するボタンをクリックする
      click_on("新規登録")
      # 新規登録ページへ移動する
      expect(current_path).to eq new_user_registration_path
      # 会員登録ボタンを押してもユーザーモデルのカウントが上がらないことを確認する
      expect{find('input[name="commit"]').click}.to change { User.count }.by(0)
      # サインアップページへ戻ってくる
      expect(current_path).to eq "/users"
    end
  end

  context '新規登録ができる' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに遷移する
      visit  root_path
      # トップページにあるサインアップページへ遷移するボタンをクリックする
      click_on("新規登録")
      # 新規登録ページへ移動する
      expect(current_path).to eq new_user_registration_path
      # ユーザー情報を入力する
      fill_in "nickname", with: @user.nickname
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      fill_in "password-confirmation", with: @user.password_confirmation
      fill_in 'first-name', with: @user.first_name
      fill_in 'last-name', with: @user.last_name
      fill_in "first-name-kana", with: @user.first_name_kana
      fill_in "last-name-kana", with: @user.last_name_kana
      select '1930', from: 'user_birthday_1i'
      select '1', from: 'user_birthday_2i'
      select '1', from: 'user_birthday_3i'
      # 会員登録ボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{find('input[name="commit"]').click}.to change { User.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
end

RSpec.describe "ログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインができないとき' do
    it 'ログインに失敗し、再びサインインページに戻ってくる' do
      # トップページに遷移する
      visit  new_user_session_path
      # ログインしていない場合、サインインページに遷移していることを確認する
      expect(current_path).to eq new_user_session_path
      # 誤ったユーザー情報を入力する
      fill_in 'email', with: "test"
      fill_in 'password', with: "test"
      # ログインボタンをクリックする
      click_on("ログイン")
      # サインインページに戻ってきていることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end

  context 'ログインができるとき' do
    it 'ログインに成功し、トップページに遷移する' do
      # サインインページへ移動する
      visit  new_user_session_path
      # ログインしていない場合、サインインページに遷移していることを確認する
      expect(current_path).to eq new_user_session_path
      # すでに保存されているユーザーのemailとpasswordを入力する
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      # ログインボタンをクリックする
      click_on("ログイン")
      # トップページに遷移していることを確認する
      expect(current_path).to eq root_path
    end
  end
end

RSpec.describe "ユーザー情報編集", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context '編集に失敗したときとき' do
    it '編集に失敗し、再び編集ページに戻ってくる' do
      # サインインする
      sign_in(@user)
      # ユーザー情報編集ページに遷移する
      visit  edit_user_registration_path
      # ユーザー情報を編集する
      fill_in 'nickname', with: "編集後のニックネーム"
      # 変更ボタンをクリックする
      click_on("変更")
      # ユーザー情報編集ページに戻ってきていることを確認する
      expect(current_path).to eq "/users"
    end
  end

  context '編集に成功したときとき' do
    it '情報が変更され、トップページに遷移する' do
      # サインインする
      sign_in(@user)
      # ユーザー情報編集ページに遷移する
      visit  edit_user_registration_path
      # ユーザー情報を編集する
      fill_in 'nickname', with: "編集後のニックネーム"
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password
      fill_in 'user_current_password', with: @user.password
      # 変更ボタンをクリックする
      click_on("変更")
      # トップページに遷移していることを確認する
      expect(current_path).to eq root_path
      # トップページに遷移していることを確認する
      expect(page).to have_content("編集後のニックネーム")
    end
  end
end