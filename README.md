# Pictweet DB設計
## postsテーブル
|Column|Type|Options|
|------|----|-------|
|image|text||
|text|text||
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: fales, foreing_key: true|
# association
- belongs_to :user
- belongs_to :group

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|email|string|null: false|
|password|string|null: false|
|nickname|string|null: false|
|group_id|integer|null: false, foreing_key: true|
# association
- has_many :posts
- has_many :users_groups
- has_many :groups, through: :users_groups

## groupsテーブル
|Column|Type|Options|
|------|----|-------|
|group_title|text|null: false|
|member_id|integer|null: false, foreign_key: true|
# association
- has_many :posts
- has_many :users_groups
- has_many :users, through: :users_groups

## 中間テーブルusers_groups
|colum|type|options|
|------|----|------|
|user_id|integer|null: false, foreing_key: true|
|group_id|integer|null: false, forering_key: true|
# association
- belongs_to :user
- belongs_to :group
