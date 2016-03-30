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
AlbumView.delete_all

#20.times do
#  User.create(f_name: Faker::Name.first_name, l_name: Faker::Name.last_name,
#  b_day: Faker::Date.birthday(min_age = 10, max_age = 30),
#  f_book: "true", default_loc: Faker::Address.city,
#  email: Faker::Internet.email, encrypted_password: Faker::Number.number(6),
#  confirmation_token: Faker::Number.number(3), remember_token: Faker::Number.number(3))
#end


20.times do
  Album.create(album_name: Faker::Address.country, user: User.all.sample, url: Faker::Internet.url('mappies'))
end

Album.create(album_name: "Landing", user: User.all.sample)
Photo.create(url:"http://imgur.com/zdfrc05.jpg", x_coord:"42.3650583", y_coord:"-71.2597494", album_id: 666)
Photo.create(url:"http://imgur.com/1a0BNE5.jpg", x_coord:"42.3673724", y_coord:"-71.2556464", album_id: 666)
Photo.create(url:"http://imgur.com/4NpP12w.jpg", x_coord:"42.3684466", y_coord:"-71.2604612", album_id: 666)
Photo.create(url:"http://imgur.com/kJ1F9A5.jpg", x_coord:"42.3691451", y_coord:"-71.2572575", album_id: 666)
Photo.create(url:"http://imgur.com/wchzPTV.jpg", x_coord:"42.3657889", y_coord:"-71.2601062", album_id: 666)


3.times do
  AlbumView.create(album: Album.all.sample, user: User.all.sample)
end
