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


  def self.pay_viewers
    require 'rest_client'
    require 'json'

    channel = 'tsm_theoddone'

    RestClient.get("http://tmi.twitch.tv/group/user/#{channel}/chatters") do |response, request, result|
      if(result.code_type <= Net::HTTPSuccess)
        #puts "Response: #{response}"
        parsed = JSON.parse(response)
        viewer_names = parsed["chatters"]["viewers"]

        viewer_names.each do |name|
          #This is inefficient, should do batch lookup for all viewer_names.
          viewer = Viewer.find_or_create_by(:name => name)
          PointTransaction.system_pay(viewer, 100)
        end
      else
        puts "BROKEN"
      end
    end
  end
end
