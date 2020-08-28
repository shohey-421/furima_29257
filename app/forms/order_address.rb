class OrderAddress

  include ActiveModel::Model

  attr_accessor :postcode, :region_id, :city, :postal_code, :prefecture, :city, :block, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :token
    validates :postcode,      format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "Include hyphen(-)"}
    validates :region_id,     numericality: { other_than: 0, message: "Select"}
    validates :city
    validates :block
    validates :phone_number,  length: { maximum: 11 }    
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postcode: postcode, region_id: region_id, city: city, block: block, building: building, phone_number:phone_number, order_id: order.id)
  end
end