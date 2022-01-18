# テーブル設計


## usersテーブル


| Column     | Type    | Options                   |
| ---------- | ------- | ------------------------- |
| nickname   | string  | null: false               |
| email      | string  | null: false               |
| password   | string  | null: false               |
| name       | string  | null: false               |
| name_read  | string  | null: false               |
| birth_date | integer | null: false               |


### Association


- has_many :items
- has_many :comments
- has_many :orders


## itemsテーブル


| Column              | Type       | Options                   |
| ------------------- | ---------- | ------------------------- |
| product_name        | text       | null: false               |
| description         | text       | null: false               |
| price               | integer    | null: false               |
| category_id         | integer    | null: false               |
| condition_id        | integer    | null: false               |
| cost_id             | integer    | null: false               |
| shipping_agent_id   | integer    | null: false               |
| shipping_address_id | integer    | null: false               |
| shipping_time_id    | integer    | null: false               |
| user                | references | null: false               |


### Association


- belongs_to :user
- has_many :comments
- belongs_to :order


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
| price              | integer    | null: false               | 
| postal_code        | integer    | null: false               |
| prefecture_id      | integer    | null: false               |
| municipalities     | string     | null: false               |
| address            | string     | null: false               |
| building           | string     |                           |
| phone_number       | integer    | null: false               |
| user               | references | null: false               |
| item               | references | null: false               |

### Association


- belongs_to :user
- belongs_to :item

