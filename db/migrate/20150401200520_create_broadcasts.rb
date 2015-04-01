class CreateBroadcasts < ActiveRecord::Migration
  def change
    create_table :broadcasts do |t|
      t.integer :viewer_id
      t.datetime :time
      t.integer :paid
      t.text :message

      t.timestamps null: false
    end
  end
end
