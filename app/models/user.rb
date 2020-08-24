class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "全角で入力してください"}
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "全角で入力してください"}
    validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: "全角カタカナで入力してください"}
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: "全角カタカナで入力してください"}
  end

  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i ,message: "英字と数字の両方を含めてください"}
end
