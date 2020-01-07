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
- has_one: shipping_address, dependent: :destroy
- has_one: identification_address, dependent: :destroy
- has_many: sns_credentials, dependent: :destroy_all
- has_many: likes

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
|price|integer|null: false|
|likes_count|integer|default: 0|
|user_id|references|foregin_key: true|
|customer_id(user_id)|references|foreign_key: true|
|category_id|references|foreign_key: true|
|size_id|references|foregin_key: true|
|brand_id|references|foreign_key: true|
- belongs_to: user
- belongs_to: category
- belongs_to: size
- belongs_to: brand
- has_one: cart, dependent: :destroy
- has_many: images, dependent: :destroy_all
- has_many: likes

## cards テーブル
|Column|Type|Options|
|------|----|-------|
|card_number|integer|null: false|
|security_code|integer|null: false|
|expriation_yyyy|integer|null: false|
|expiration_mm|integer|null: false|
|user_id|references|foreign_key: true|
- belongs_to: user

## shipping_addresses テーブル
|Column|Type|Options|
|------|----|-------|
|postal_code|integer|null: false|
|address|string|null: false|
|building|string|null: false|
|prefecture|string|null: false|
|telephone|integer|null: false|
|user_id|references|foregn_key: true|
- belongs_to: user

## identification_addresses テーブル
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

## sizes テーブル
|Column|Type|Options|
|------|----|-------|
|size|string|null: false|
- has_many: products

## brands テーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
- has_many: products

## carts テーブル
|Column|Type|Options|
|------|----|-------|
|receipt_date|integer||
|transaction_condition|string|null: false|
|product_id|references|foreign_key: true|
- belongs_to: product

## images テーブル
|Column|Type|Options|
|------|----|-------|
|image|string||
|product_id|references|foreign_key: true|
- belongs_to: product

## likes テーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|product_id|references|foreign_key: true|
- belongs_to: user
- belongs_to: product
