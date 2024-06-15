# テーブル設計

## users テーブル

| Column             | Type   | Options                        |
| ------------------ | ------ | ------------------------------ |
| email              | string | null: false, unique: true      |
| encrypted_password | string | null: false                    |
| nickname           | string | null: false                    |
| kanji_name_sei     | string | null: false                    |
| kanji_name_mei     | string | null: false                    |
| kana_name_sei      | string | null: false                    |
| kana_name_mei      | string | null: false                    |
| birthday           | date   | null: false                    |

### Association

- has_many :items
- has_many :orders
- has_many :comments

## items テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| item_name          | string     | null: false                    |
| item_description   | text       | null: false                    |
| category_id        | integer    | null: false                    |
| price              | integer    | null: false                    |
| condition_id       | integer    | null: false                    |
| shipping_cost_id   | integer    | null: false                    |
| prefecture_id      | integer    | null: false                    |
| shipping_date_id   | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order
- has_many :comments

## orders テーブル

| Column                | Type       | Options                        |
| --------------------- | ------     | ------------------------------ |
| user                  | references | null: false, foreign_key: true |
| item                  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column                 | Type       | Options                        |
| ---------------------  | ---------- | ------------------------------ |
| post_code              | string     | null: false                    |
| prefecture_id          | integer    | null: false                    |
| address_municipalities | string     | null: false                    |
| address_street         | string     | null: false                    |
| address_building       | string     |                                |
| phone_number           | string     | null: false                    |
| order                  | references | null: false, foreign_key: true |

### Association

- belongs_to :order

## comments テーブル

| Column    | Type       | Options                        |
| -------   | ---------- | ------------------------------ |
| content   | string     |                                |
| item      | references | null: false, foreign_key: true |
| user      | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
