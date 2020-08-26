class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_burden
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_date

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :category_id, numericality: { other_than: 1 }
    validates :condition_id	, numericality: { other_than: 1 }
    validates :shipping_burden_id, numericality: { other_than: 1 }
    validates :ship_from_id, numericality: { other_than: 1 }
    validates :shipping_date_id, numericality: { other_than: 1 }
    validates :price, between: {300,9999999}, format: { with: /^[0-9]+$/, message: "Full-width characters"}
  end

  belongs_to :user
  has_one_attached :image
end
