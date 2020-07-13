# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"

# データベース上にサンプルユーザーを生成するRailsタスク
suser_num = 15

suser_num.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@rails.org"
  img = URI.encode Faker::Avatar.image[/^.*.png/] # ImageUploaderの拡張子バリデーションをコメントアウトする必要あり
  password = "password"
  User.create!({name:  name,
      email:          email,
      image:          open(img),
      password:              password,
      password_confirmation: password})
  lv = rand(100)
  str = rand(100)
  vit = rand(100)
  dex = rand(100)
  int = rand(100)
  spe = rand(100)
  State.create(user_id: n+1, lv: lv, str: str, vit: vit, dex: dex, int: int, spe: spe, point: 30)
  5.times do |m|
    Record.create(user_id: n+1, act_content: Faker::Lorem.sentence, grow_content: Faker::Lorem.sentence)
  end
end

User.create!(name:  "テストユーザー",
  email: "test@user.jp",
  password:              "123456",
  password_confirmation: "123456",
  )
State.create(user_id: suser_num + 1, point: 99)

5.times do |n|
  Record.create(user_id:2, act_content: "#{n+1}日目の行動", grow_content: "#{n+1}の強さを得た。")
end

