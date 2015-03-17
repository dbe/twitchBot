class CreatePointTransactions < ActiveRecord::Migration
  def change
    create_table :point_transactions do |t|
      t.integer :from_id
      t.integer :to_id
      t.integer :amount
      t.datetime :time

      t.timestamps null: false
    end
  end
end
