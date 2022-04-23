class CreateWallets < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets do |t|
      t.integer :user_id
      t.string  :name
      t.float  :total

      t.timestamps
    end
  end
end
