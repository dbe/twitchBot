class Stream < ActiveRecord::Base

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

end
