require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'nickname、email、password、password_confirmation、last_name、first_name、last_name_kana、first_name_kana、birthdayが存在すれば登録できること' do
      expect(@user).to be_valid
    end

    it 'nicknameが空では登録できないこと' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("ニックネームを入力してください")
    end

    it 'emailが空では登録できないこと' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールを入力してください")
    end

    it 'passwordが空では登録できないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください")
    end
    it 'passwordが存在してもpassword_confirmationが空では登録できないこと' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end
    it 'last_nameが空では登録できないこと' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("苗字を入力してください")
    end
    it 'first_nameが空では登録できないこと' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("名前を入力してください")
    end
    it 'last_name_kanaが空では登録できないこと' do
      @user.last_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("苗字（カナ）を入力してください")
    end
    it 'first_name_kanaが空では登録できないこと' do
      @user.first_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("名前（カナ）を入力してください")
    end
    it 'birthdayが空では登録できないこと' do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("生年月日を入力してください")
    end
    it 'passwordが英数字6文字以上であれは登録できること' do
      @user.password = '123abc'
      @user.password_confirmation = '123abc'
      expect(@user).to be_valid
    end
    it 'passwordが英数字5文字以下では登録できないこと' do
      @user.password = '123ab'
      @user.password_confirmation = '1234ab'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
    end
    it 'passwordが半角英字のみでは登録できないこと' do
      @user.password = 'abcdef'
      @user.password_confirmation = 'abcdef'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは英数字の両方を使用してください')
    end
    it 'passwordが半角数字のみでは登録できないこと' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは英数字の両方を使用してください')
    end

    it '重複したemailが存在する場合は登録できないこと' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
    end
    it 'emailが@を含まなければ登録できないこと' do
      @user.email = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールは不正な値です')
    end
    it 'last_nameが半角文字では登録できないこと' do
      @user.last_name = 'myouji'
      @user.valid?
      expect(@user.errors.full_messages).to include('苗字は全角で入力してください')
    end
    it 'first_nameが半角文字では登録できないこと' do
      @user.first_name = 'namae'
      @user.valid?
      expect(@user.errors.full_messages).to include('名前は全角で入力してください')
    end
    it 'last_name_kanaが全角カタカナ以外では登録できないこと' do
      @user.last_name_kana = 'みょうじ'
      @user.valid?
      expect(@user.errors.full_messages).to include('苗字（カナ）は全角カタカナで入力してください')
    end
    it 'first_name_kanaが全角カタカナ以外では登録できないこと' do
      @user.first_name_kana = 'なまえ'
      @user.valid?
      expect(@user.errors.full_messages).to include('名前（カナ）は全角カタカナで入力してください')
    end
  end
end
