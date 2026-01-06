## users

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|encrypted_password|string|null: false|
|last_name|string|null: false|
|first_name|string|null: false|
|kana_last_name|string|null: false|
|kana_first_name|string|null: false|
|dateofbirth|date|null: false|


### Association
- has_many :items
- has_many :purchases

## items
|Column|Type|Options|
|------|----|-------|
|item_name|string|null: false|
|item_description|text|null: false|
|category_id|integer|null: false|
|condition_id|integer|null: false|
|shipping_fee_id|integer|null: false|
|prefecture_id|integer|null: false|
|shipping_day_id|integer|null: false|
|price|integer|null: false|
|user|references|null: false, foreign_key: true|

## items
- belongs_to :user
- has_one :purchase 

## purchases
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|item|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping_address

## shipping_addresses
|Column|Type|Options|
|------|----|-------|
|postal_code|string|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|address|string|null: false|
|building_name|string|-------|
|phone_number|string|null: false|
|purchase|references|null: false, foreign_key: true|

### Association
- belongs_to :purchase