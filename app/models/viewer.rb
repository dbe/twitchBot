class Viewer < ActiveRecord::Base
  has_many :point_credits, :class_name => 'PointTransaction', :foreign_key => 'to_id'
  has_many :point_debits, :class_name => 'PointTransaction', :foreign_key => 'from_id'
  has_many :broadcasts

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


  def self.pay_viewers
    puts "Paying viewers"

    Stream.all.each do |stream|
      puts "Paying viewers of stream: #{stream.name}"
      viewers = stream.fetch_viewers
      puts "Stream had #{viewers.count} viewers"

      viewers.each do |viewer|
        PointTransaction.system_pay(viewer, 100, stream)
      end
    end
  end

end
