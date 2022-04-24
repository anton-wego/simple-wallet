# overview
Simple wallet is simulation deposit, withdraw, and transfer to e-wallet. 

# simple-wallet

* Ruby version
   `ruby 3.0.1p64 (2021-04-05 revision 0fb782ee38) [x86_64-darwin19]`

* Rails version
   `Rails 6.1.5`

* Database
   `mysql`

* Database creation
   `rake db:setup`
   `rake db:migration`

* Database initialization
   `rake db:seed`

# Assumption
- user only 3 users
- user login always 'user 1' (never login)
- one user only has one wallet (cant add user and wallet)
- can't edit data (user, wallet, transaction)
- rspec not yet created.
