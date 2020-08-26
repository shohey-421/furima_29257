class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_burden
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_date

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :condition_id	
    validates :shipping_burden_id
    validates :ship_from_id
    validates :shipping_date_id
  end

  belongs_to :user
end
