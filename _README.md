# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration/https://qiita.com/linkss/items/9b005ebc2ef81a39afa2

* Database creation/https://qiita.com/kazuooooo/items/47e7d426cbb33355590e

* Database initialization /一括登録/API/https://qiita.com/akioneway94/items/35641ad30c2acb23b562

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
* https://qiita.com/kohei_abe/items/2a900d1580a38275d924
* https://qiita.com/junara/items/ddba402e277afd5d38b2
* https://teratail.com/questions/55470
* ...

ポートフォリオ作成目的
正確に、迅速に情報共有

■オペレーター
Excelのファイルにて予約を管理していたため、
誰かが開けていると書き込めなかったり、最新の情報が取得できず。
そのため電話での問い合わせがあったときは仮受付とし
予約が取れない場合、改めて電話をかけるなど、工数がかかっていた。

■管理者
電話受付している時間帯は、上記の通り、オペレータが編集しているため
管理ファイルの更新は、受付時間外に行うなどリアルタイムに更新できない。
また、オペレーターへ周知事項がある場合、電話対応中などの理由により
全オペレーターへ徹底することが難しい。


本アプリを導入することで期待される効果
１．電話応対しながら予約を確定することができ、後処理が減る。
　　また、お客様へ即答できることで満足度が得られる。

２．任意のタイミングで各種情報を更新～業務連絡を通達することができるため
　　素早く情報を共有することができる。
　　
　　--
　　Devise.setup do |config|
  # ...

  config.omniauth :google_oauth2, ENV['GOOGLE_APP_ID'], ENV['GOOGLE_APP_SECRET']
end

--
GOOGLE_APP_ID='525155116426-5ioam4thg9g06gp1t2q15kakt9j55vnc.apps.googleusercontent.com'
GOOGLE_APP_SECRET='NECiunjlQQqDVGx25xL9QINR'



--
  #create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "department"
    t.datetime "basic_time", default: "2021-05-07 00:00:00"
    t.datetime "work_time", default: "2021-05-07 08:00:00"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  #end
  https://qiita.com/penguin_note/items/93b00c09c0da1f1a0eab