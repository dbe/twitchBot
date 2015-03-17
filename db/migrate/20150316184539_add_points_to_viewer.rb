class AddPointsToViewer < ActiveRecord::Migration
  def change
    add_column :viewers, :points, :integer, :default => 0
  end
end
