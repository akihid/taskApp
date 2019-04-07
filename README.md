以下にテーブル構成を記載

---

Users

|カラム名  |型  | メモ
|---|---|---|
|**id**	| **integer** | 
|name	| string | User名
|mail	| striing | メールアドレス
|password_digest	| string | パスワード

---

Tasks

|カラム名  |型  |メモ |
|---|---|---|
|**id**	| **integer** | 
|**user_id(FK)**	| **integer** | 
|title	| striing | タスク名
|content	| text | タスクの内容
|deadline_at	| date | 期限
|priority	| string | 優先度
|status	| string | ステータス

---

Lables

|カラム名  |型  |メモ |
|---|---|---|
|**id**	| **integer**
|word	| string | ラベル名

---

Task_labels

|カラム名  |型  |メモ |
|---|---|---|
|**id**	| **integer**
|**task_id(FK)**	| **integer**
|**label_id(FK)**	| **integer**

---

* デプロイ手順

```
heroku create
heroku buildpacks:set heroku/ruby
heroku buildpacks:add --index 1 heroku/nodejs
git push heroku master
heroku run rails db:migrate
```