# frozen_string_literal: true

# This file should contain all the record creation needed
#   to seed the database with its default values.
# The data can then be loaded with the rails db:seed command
#   (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' },
#                          { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
  { username: 'user 1', email: 'user_1@mail.com' },
  { username: 'user 2', email: 'user_2@mail.com' },
  { username: 'user 2', email: 'user_2@mail.com' }
]

wallet = [
  { name: 'wallet 1', total: 10 },
  { name: 'wallet 2', total: 12 },
  { name: 'wallet 3', total: 13 }
]

users.each_with_index do |user, i|
  u = User.new user
  u.save

  Wallet.create wallet[i].merge({ user_id: u.id })
end

user_records = User.all

# Depost
deposits = [
  { total: 10 },
  { total: 100 },
  { total: 1000 }
]
deposits.each_with_index do |dep, i|
  Deposit.create_transaction(
    dep.merge({ user_id: user_records[i].id,
                target_id: user_records[i].wallet.id })
  )
end

# withdraw
withdraw = [
  { total: 5 },
  { total: 10 },
  { total: 240 }
]
withdraw.each_with_index do |wd, i|
  Withdraw.create_transaction(
    wd.merge({
               user_id: user_records[i].id,
               source_id: user_records[i].wallet.id
             })
  )
end

# transfer
transfers = [
  # send money
  { user_id: user_records[0].id, source_id:  user_records[0].wallet.id,
    target_id: user_records[1].wallet.id, total: 1 },
  { user_id: user_records[1].id, source_id:  user_records[1].wallet.id,
    target_id: user_records[2].wallet.id, total: 10 },
  { user_id: user_records[2].id, source_id:  user_records[2].wallet.id,
    target_id: user_records[0].wallet.id, total: 150 }

]
transfers.each do |wd|
  Transfer.create_transaction(wd)
end
