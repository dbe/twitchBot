class Stream < ActiveRecord::Base
  has_many :point_transaction

  def fetch_viewers
    require 'rest_client'
    require 'json'

    viewers = []

    if self.name
      RestClient.get("http://tmi.twitch.tv/group/user/#{self.name}/chatters") do |response, request, result|
        if(result.code_type <= Net::HTTPSuccess)
          parsed = JSON.parse(response)
          viewer_names = parsed["chatters"]["viewers"]

          viewers = viewer_names.map do |name|
            #This is inefficient, should do batch lookup for all viewer_names.
            Viewer.find_or_create_by(:name => name)
          end
        else
          puts "Api request failed."
          puts "Response: #{response}"
          puts "Request: #{request}"
          puts "Result: #{result}"
        end
      end
    end

    return viewers
  end

  #{:viewer, :points}
  #Memoized for performance, may be an issue for consistency
  def supporters
    if not @supporters
      @supporters = []

      PointTransaction.includes(:to).where(:stream => self).group_by(&:to).each do |viewer, transactions|
        @supporters.push({:viewer => viewer, :points => transactions.map(&:amount).reduce(:+)})
      end
    end

    return @supporters
  end

  def points_generated
    if not @points_generated
      @points_generated = 0

      if self.supporters.any?
        @points_generated = (self.supporters.map {|s| s[:points]}).reduce(:+)
      end
    end

    return @points_generated
  end
end
