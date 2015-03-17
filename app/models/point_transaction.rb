class PointTransaction < ActiveRecord::Base
  belongs_to :from, :class_name => 'Viewer'
  belongs_to :to, :class_name => 'Viewer'
end
