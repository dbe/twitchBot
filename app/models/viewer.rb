class Viewer < ActiveRecord::Base
  has_many :point_credits, :class_name => 'PointTransaction', :foreign_key => 'to_id'
  has_many :point_debits, :class_name => 'PointTransaction', :foreign_key => 'from_id'

  #Should db lock go in here or in the point transaction? 
  def withdrawl(amount)
    points = self.points
    if(points < amount)
      raise Exception.new("Insufficient funds")
    else
      self.update_attributes(:points => points - amount)
    end
  end

  def deposit(amount)
    points = self.points
    self.update_attributes(:points => points + amount)
  end
end
