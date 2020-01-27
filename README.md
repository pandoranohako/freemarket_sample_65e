# freemarket_sample_65e DB設計

## users テーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false|
|password|string|null: false|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthday_yyyy|integer|null: false|
|birthday_mm|integer|null: false|
|birthday_dd|integer|null: false|
|authentication_number|integer|null: false|
- has_many: products, dependent: :destroy_all
- has_one: card_infomation, dependent: :destroy
- has_one: address, dependent: :destroy
- has_many: sns_credentials, dependent: :destroy_all

## products テーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|description|text|null: false|
|condition|string|null: false|
|shipping_fee|string|null: false|
|shipping_how|string|null: false|
|shipping_from|string|null: false|
|shipping_date|string|null: false|
|size|string|null: false|
|brand|string|
|price|integer|null: false|
|user_id|references|foregin_key: true|
|customer_id(user_id)|references|foreign_key: true|
|category_id|references|foreign_key: true|

- belongs_to: user
- belongs_to: category
- has_many: images, dependent: :destroy_all

## cards テーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true| Userテーブルのid
|customer_id|string|null: false| payjpの顧客id
|card_id|string|null: false| payjpのデフォルトカードid
- belongs_to: user

## addresses テーブル
|Column|Type|Options|
|------|----|-------|
|postal_code|integer|null: false|
|address|string|null: false|
|building|string|null: false|
|prefecture|string|null: false|
|telephone|integer|null: false|
|user_id|references|foregn_key: true|
- belongs_to: user

## sns_credentials テーブル
|Column|Type|Options|
|------|----|-------|
|uid|string|null: false, unique: true|
|provider|string|null: false|
|token|text||
|user_id|references|foreign_key: true|
- belongs_to: user

## categorys テーブル
|Column|Type|Options|
|------|----|-------|
|category|string|null: false|
|ancestry|string|index: true|
- has_many: products
- has_ancestry

## images テーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|product_id|references|foreign_key: true|
- belongs_to: product

