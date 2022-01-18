# テーブル設計


## usersテーブル


| Column               | Type    | Options                   |
| -------------------- | ------- | ------------------------- |
| nickname             | string  | null: false               |
| email                | string  | null: false, unique: true |
| encrypted_password   | string  | null: false               |
| last_name            | string  | null: false               |
| first_name           | string  | null: false               |
| last_name_read       | string  | null: false               |
| first_name_read      | string  | null: false               |
| birth_date           | date    | null: false               |


### Association


- has_many :items
- has_many :comments
- has_many :orders
- has_many :delivery_addresses


## itemsテーブル


| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| product_name        | string     | null: false                    |
| description         | text       | null: false                    |
| category_id         | integer    | null: false                    |
| condition_id        | integer    | null: false                    |
| shipping_cost_id    | integer    | null: false                    |
| shipping_agent_id   | integer    | null: false                    |
| shipping_address_id | integer    | null: false                    |
| shipping_time_id    | integer    | null: false                    |
| price               | integer    | null: false                    |
| user                | references | null: false, foreign_key: true |


### Association


- belongs_to :user
- has_many :comments
- has_one :order
- has_one :delivery_address


## commentsテーブル


| Column   | Type       | Options                   |
| -------- | ---------- | ------------------------- |
| content  | text       | null: false               |
| user     | references | null: false               |
| item     | references | null: false               |


### Association


- belongs_to :user
- belongs_to :item


## ordersテーブル


| Column             | Type       | Options                   |
| ------------------ | ---------- | ------------------------- |
| user               | references | null: false               |
| item               | references | null: false               |


### Association


- belongs_to :user
- has_one :item
- has_one :delivery_address


## delivery_addresses


| Column             | Type       | Options                   |
| ------------------ | ---------- | ------------------------- | 
| postal_code        | integer    | null: false               |
| prefecture_id      | integer    | null: false               |
| municipalities     | string     | null: false               |
| address            | string     | null: false               |
| building           | string     |                           |
| phone_number       | integer    | null: false               |


### Association


- belongs_to :user
- has_one :item
- has_one :order





