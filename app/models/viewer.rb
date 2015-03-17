class Viewer < ActiveRecord::Base
  has_many :point_credits, :class_name => 'PointTransaction', :foreign_key => 'to_id'
  has_many :point_debits, :class_name => 'PointTransaction', :foreign_key => 'from_id'
end
