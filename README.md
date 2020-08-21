# テーブル設計

## users テーブル

| Column            | Type   | Options                  | 
| ----------------- | ------ | ------------------------ | 
| nickname          | string | null: false              | 
| email             | string | null: false, unique: true| 
| password          | string | null: false              | 
| last_name         | string | null: false              | 
| first_name        | string | null: false              | 
| last_name_kana    | string | null: false              | 
| first_name_kana   | string | null: false              | 
| birthday          | date   | null: false              | 

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column          | Type       | Options                        | 
| --------------- | ---------- | ------------------------------ | 
| name            | string     | null: false                    | 
| description     | text       | null: false                    | 
| category        | string     | null: false                    | 
| condition       | string     | null: false                    | 
| shipping_burden | string     | null: false                    | 
| ship_from       | string     | null: false                    | 
| shipping_date   | integer    | null: false                    | 
| price           | integer    | null: false                    | 
| user_id         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
- has_one :address

## address テーブル
                   
| Column       | Type       | Options                        | 
| ------------ | ---------- | ------------------------------ | 
| postcode     | string     | null: false                    | 
| region       | string     | null: false                    | 
| city         | string     | null: false                    | 
| block        | string     | null: false                    | 
| building     | string     | null: false                    | 
| phone_number | integer    | null: false                    | 
| order_id     | references | null: false, foreign_key: true |

### Association

- belongs_to :order