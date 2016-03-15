# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

User.delete_all
Photo.delete_all
Album.delete_all

20.times do
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
  birthday: Faker::Date.birthday(min_age = 10, max_age = 30),
  f_book: "true", default_loc: Faker::Address.city,
  email: Faker::Internet.email, encrypted_password: Faker::Number.number(6),
  confirmation_token: Faker::Number.number(3), remember_token: Faker::Number.number(3))
  #t.string  "email"
  #t.string  "encrypted_password", limit: 128
  #t.string  "confirmation_token", limit: 128
  #t.string  "remember_token",
end

20.times do
    Friend.create(friender: User.all.sample, friendee: User.all.sample)
end

20.times do
  Album.create(album_name: Faker::Address.country, user: User.all.sample)
end

Album.create(album_name: "Landing", user: User.all.sample)
Photo.create(url:"http://imgur.com/zdfrc05.jpg", x_coord:"42.3650583", y_coord:"-71.2597494", album_id: 666)
Photo.create(url:"http://imgur.com/1a0BNE5.jpg", x_coord:"42.3673724", y_coord:"-71.2556464", album_id: 666)
Photo.create(url:"http://imgur.com/4NpP12w.jpg", x_coord:"42.3684466", y_coord:"-71.2604612", album_id: 666)
Photo.create(url:"http://imgur.com/kJ1F9A5.jpg", x_coord:"42.3691451", y_coord:"-71.2572575", album_id: 666)
Photo.create(url:"http://imgur.com/wchzPTV.jpg", x_coord:"42.3657889", y_coord:"-71.2601062", album_id: 666)

100.times do
  Photo.create(url: Faker::Internet.url('mappies'),
  x_coord: Faker::Address.latitude, y_coord: Faker::Address.longitude,
  album: Album.all.sample)
end

3.times do
  AlbumView.create(album: Album.all.sample, user: User.all.sample)
end
