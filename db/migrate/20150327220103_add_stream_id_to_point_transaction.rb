class AddStreamIdToPointTransaction < ActiveRecord::Migration
  def change
    add_column :point_transactions, :stream_id, :integer
  end
end
