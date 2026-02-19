class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :purchase_id, :user_id, :item_id,
                :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)', allow_blank: true }
    validates :prefecture_id, numericality: { other_than: 1, message: 'must be selected' }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d+\z/, message: 'is invalid. Input only number', allow_blank: true },
                             length: { minimum: 10, too_short: 'is invalid. Input less than 10 digits',
                                       maximum: 11, too_long: 'is invalid. Input more than 11 digits', allow_blank: true }
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      address: address,
      building_name: building_name,
      phone_number: phone_number,
      purchase_id: purchase.id
    )
  end
end
