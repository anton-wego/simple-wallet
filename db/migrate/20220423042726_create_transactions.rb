class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :source_id
      t.integer :target_id
      t.float   :total
      t.string  :type

      t.timestamps
    end
  end
end


