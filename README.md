# 顧客管理アプリ

## 何を解決したいのか
- 営業活動の効率化

## テーブル設計

### Tenantsテーブル

Webサイト利用テナントを格納するテーブル

|name|type|description|
| --- | --- | --- |
|name|string|テナント利用者名|
|postal_code|string|郵便番号|
|prefecture_id|integer|都道府県ID|
|city|string|市町村|
|address1|string|番地|
|address2|string|ビル・マンション名等|

#### Relation

```
has_many :customers, dependent: :destroy
has_many :users, dependent: :destroy
has_many :ips, dependent: :destroy
```

### customersテーブル

顧客を格納するテーブル

|name|type|description|
| --- | --- | --- |
|contract_status|integer|顧客属性 enumで管理 既存顧客・見込み顧客・休眠顧客|
|name|string|名称|
|postal_code|string|郵便番号|
|prefecture_id|integer|都道府県ID|
|city|string|市町村|
|address1|string|番地|
|address2|string|ビル・マンション名等|

#### Relation

```
belongs_to :tenant

has_many :contacts, dependent: :destroy
```

### contactsテーブル

顧客へのコンタクト履歴を格納するテーブル

|name|type|description|
| --- | --- | --- |
|contacted_at|date|顧客接触日|
|way|integer|接触手段 enumで管理 電話・メール・アポイント|
|purpose|integer|接触目的 enumで管理 提案・契約・その他|
|subject|string|タイトル|
|content|text|コンテンツ|
|target|integer|接触対象者|

#### Relation

```
belongs_to :customer
belongs_to :user
```

### usersテーブル

システム利用者を格納するテーブル

|name|type|description|
| --- | --- | --- |
|last_name|string|姓 null: false|
|first_name|string|名 null: false|
|last_name_kana|string|カナ姓 null: false|
|first_name_kana|string|カナ名 null: false|
|image|string|画像|
|email|string|メールアドレス null: false|
|birthday|date|誕生日 null: false|
|sex|boolean|性別 null: false|
|administrator|boolean|性別 default: false, null: false|
|disable|boolean|アカウントが有効かどうか default: false, null: false|
|prefecture_id|integer|出身都道府県コード default: false, null: false|
|tenant_id|bigint|外部キー null: false|
|manager_id|bigint|自己参照キー optional: true|

#### Relation

```
belongs_to :tenant
belongs_to :manager, class_name: 'User', optional: true

has_one :operation, dependent: :destroy

has_many :contacts, dependent: :destroy
has_many :daily_reports, dependent: :destroy
```

### ipsテーブル

IPアドレス制限を実施するテーブル

|name|type|description|
| --- | --- | --- |
|tenant_id|bigint|外部キー null: false|
|content|string|IPアドレス null: false|

#### Relation

```
belongs_to :tenant
```

### operationsテーブル

各種機能制限に関するテーブル

|name|type|description|
| --- | --- | --- |
|operate_ip|boolean|IPアドレス制限を操作できるかどうか default: false, null: false|
|operate_contact|boolean|コンタクト履歴の更新・削除ができるかどうか default: false, null: false|
|operate_user|boolean|ユーザーの追加・更新・削除ができるかどうか default: false, null: false|
|operate_daily_report|boolean|業務日報の更新・削除ができるか default: false, null: false|
|user_id|bigint|外部キー null: false|

#### Relation

```
belongs_to :user
```

### daily_reportsテーブル

業務日報を管理するテーブル

|name|type|description|
| --- | --- | --- |
|user_id|bigint|外部キー null: false|
|status|integer|enumで管理 :draft, :published, :private null: false|
|problem|string|問題|
|improvement|string|改善点|
|consultation|string|相談したいこと|

#### Relation

```
belongs_to :user
```


### daily_report_commentsテーブル

業務日報へのコメントを管理するテーブル

|name|type|description|
| --- | --- | --- |
|daily_report_id|bigint|外部キー null: false|
|user_id|bigint|外部キー null: false|
|content|string|本文, null: false|

#### Relation

```
belongs_to :daliy_report
belongs_to :user
```

### schedulesテーブル

スケジュール管理するテーブル

|name|type|description|
| --- | --- | --- |
|user_id|bigint|外部キー null: false|
|date|date|日付|
|start_time|time|開始時刻|
|end_time|time|終了時刻|
|subject|string|件名|
|content|text|本文|

#### Relation

```
belongs_to :user
```
