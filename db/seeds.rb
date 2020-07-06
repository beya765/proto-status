# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# データベース上にサンプルユーザーを生成するRailsタスク
User.create!(name:  "beya",
  email: "kenshinpower2000@yahoo.co.jp",
  password:              "123456",
  password_confirmation: "123456",
  )
State.create(user_id: 1, point: 30)

20.times do |n|
  Record.create(user_id:1, act_content: "#{n+1}日目の行動", grow_content: "#{n+1}の強さを得た。")
end
