# テーブル設計

## users テーブル

| Column             | Type   | Options                        |
| ------------------ | ------ | ------------------------------ |
| email              | string | null: false                    |
| encrypted_password | string | null: false, unique: true      |
| nickname           | string | null: false                    |
| kanji_name_sei     | string | null: false                    |
| kanji_name_mei     | string | null: false                    |
| kana_name_sei      | string | null: false                    |
| kana_name_mei      | string | null: false                    |
| birthday           | date   | null: false                    |

### Association

- has_many :items
- has_many :purchases
- has_many :comments

## items テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| item_name          | string     | null: false                    |
| item_description   | text       | null: false                    |
| category           | string     | null: false                    |
| price              | int        | null: false                    |
| condition          | string     | null: false                    |
| shipping_cost      | string     | null: false                    |
| seller_region      | string     | null: false                    |
| shipping_date      | string     | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- belong_to :user
- has_one :purchase
- has_many :comments

## purchases テーブル

| Column                | Type       | Options                        |
| --------------------- | ------     | ------------------------------ |
| user                  | references | null: false, foreign_key: true |
| item                  | references | null: false, foreign_key: true |

### Association

- belong_to :user
- belong_to :item
- has_one :address

## addresses テーブル

| Column                 | Type       | Options                        |
| ---------------------  | ---------- | ------------------------------ |
| post_code              | string     | null: false                    |
| address_prefectures    | string     | null: false                    |
| address_municipalities | string     | null: false                    |
| address_street         | string     | null: false                    |
| address_building       | string     |                                |
| phone_number           | string     | null: false                    |
| purchase               | references | null: false, foreign_key: true |

### Association

- belong_to :purchase

## comments テーブル

| Column    | Type       | Options                        |
| -------   | ---------- | ------------------------------ |
| content   | string     |                                |
| item      | references | null: false, foreign_key: true |
| user      | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
