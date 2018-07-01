# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
  name: "川島慎語",
  birthday: "1990-08-12",
  sex: 0,
  school: "ワンスター",
  email: "shingo.kawashima@one-star.jp",
  password: "123",
  user_type: 0
)
User.create(
  name: "メンター1",
  birthday: "1990-01-01",
  sex: 0,
  school: "メンター1",
  email: "mentor_1@gmail.com",
  password: "123",
  user_type: 1
)
User.create(
  name: "メンター2",
  birthday: "1990-01-01",
  sex: 1,
  school: "メンター2",
  email: "mentor_2@gmail.com",
  password: "123",
  user_type: 1
)

10.times do |number|
  User.create(
    name: "テスト#{number}",
    birthday: "1990-01-01",
    sex: 0,
    school: "テスト#{number}",
    email: "test_#{number}@gmail.com",
    password: "123",
    user_type: 0
  )
end

20.times do |number|
  Interview.create(user_id: 1, start_date: Time.now + 60*60*24*(30*6+"#{number}".to_i))
end
