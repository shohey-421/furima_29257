class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_burden
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_date

  belongs_to :user

  has_one_attached :image
  validate :image_presence
  def image_presence
    unless image.attached? then
      errors.add(:image, "can't be blank")
    end
  end
  
  with_options presence: true do
    validates :name
    validates :description
    validates :category_id, numericality: { other_than: 0, message: "Select"}
    validates :condition_id	, numericality: { other_than: 0, message: "Select"}
    validates :shipping_burden_id, numericality: { other_than: 0, message: "Select"}
    validates :ship_from_id, numericality: { other_than: 0, message: "Select" }
    validates :shipping_date_id, numericality: { other_than: 0, message: "Select"}
    validates :price, numericality: { only_integer: true, message: "Half-width number"}
  end

    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "Out of setting range"}

end
