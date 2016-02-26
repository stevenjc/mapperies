# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.delete_all
Photo.delete_all
Album.delete_all

20.times do
  User.create(f_name: Faker::Name.first_name, l_name: Faker::Name.last_name,
  b_day: Faker::Date.birthday(min_age = 10, max_age = 30),
  f_book: "true", default_loc: Faker::Address.city)
  Friend.create(user: User.all.sample)
end


100.times do
  Photo.create(url: Faker::Internet.url('mappies'),
  x_coord: Faker::Address.latitude, y_coord: Faker::Address.longitude,
  album: Album.all.sample)
end

20.times do
  Album.create(album_name: Faker::Address.country,
  user: User.all.sample)
end

3.times do
  Album_view.create(album: Album.all.sample, user: User.all.sample)
end
