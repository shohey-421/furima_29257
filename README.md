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

| Column             | Type       | Options                        | 
| ------------------ | ---------- | ------------------------------ | 
| name               | string     | null: false                    | 
| description        | text       | null: false                    | 
| category_id        | integer    | null: false                    | 
| condition_id       | integer    | null: false                    | 
| shipping_burden_id | integer    | null: false                    | 
| ship_from_id       | integer    | null: false                    | 
| shipping_date_id   | integer    | null: false                    | 
| price              | integer    | null: false                    | 
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
- has_one :address

## address テーブル
                   
| Column       | Type       | Options                        | 
| ------------ | ---------- | ------------------------------ | 
| postcode     | string     | null: false                    | 
| region_id    | integer    | null: false                    | 
| city         | string     | null: false                    | 
| block        | string     | null: false                    | 
| building     | string     |                                | 
| phone_number | integer    | null: false                    | 
| order        | references | null: false, foreign_key: true |

### Association

- belongs_to :order