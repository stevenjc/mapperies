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
  User.create(name: Faker::Name.name, password_digest: Faker::Number.number(6))
  Friend.create(user_id: User.all.sample)
end


100.times do
  Photo.create(xcoord: Faker::Address.latitude, ycoord: Faker::Address.longitude,
  album_id: Album.all.sample)
end

20.times do
  Album.create(album_name: Faker::Address.country,
  user_id: User.all.sample)
end

3.times do
  Album_view.create(album_id: Album.all.sample, user_id: User.all.sample)
end
