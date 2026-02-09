FactoryBot.define do
  factory :purchase_address do
    postal_code   { '123-4567' }
    prefecture_id { rand(2..48) }
    city          { '横浜市緑区' }
    address       { '青山1-1-1' }
    building_name { 'ランドマークタワー' }
    phone_number  { '09012345678' }
  end
end
