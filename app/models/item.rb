class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_burden
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_date

  belongs_to :user
  has_one :order
  has_many :comments

  has_many_attached :images
  validate :image_presence
  def image_presence
    errors.add(:images, "は必須です") unless images.attached?
  end

  with_options presence: true do
    validates :name
    validates :description
    validates :category_id, numericality: { other_than: 0, message: 'を選択してください' }
    validates :condition_id, numericality: { other_than: 0, message: 'を選択してください' }
    validates :shipping_burden_id, numericality: { other_than: 0, message: 'を選択してください' }
    validates :ship_from_id, numericality: { other_than: 0, message: 'を選択してください' }
    validates :shipping_date_id, numericality: { other_than: 0, message: 'を選択してください' }
    validates :price, numericality: { only_integer: true, message: 'は半角数字で入力してください' }
  end

  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'は¥300〜9,999,999で入力してください' }

  def previous
    Item.where("id < ?", self.id).order("id DESC").first
  end
 
  def next
    Item.where("id > ?", self.id).order("id ASC").first
  end

end
