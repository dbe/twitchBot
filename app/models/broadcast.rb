class Broadcast < ActiveRecord::Base
  belongs_to :viewer

  def self.current
    Broadcast.order('time DESC').limit(1).first
  end

end
