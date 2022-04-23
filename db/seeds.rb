# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
  { username: 'user 1', email: 'user_1@mail.com' },
  { username: 'user 2', email: 'user_2@mail.com' },
  { username: 'user 2', email: 'user_2@mail.com' }
]

wallet = [
  { name: 'wallet 1', total: 0 },
  { name: 'wallet 2', total: 0 },
  { name: 'wallet 3', total: 0 },
]

users.each_with_index do |user,i|
  u = User.new user
  u.save
  byebug
  Wallet.create wallet[i].merge({ user_id: u.id})
end

