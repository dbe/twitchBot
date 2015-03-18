namespace :tb do

  desc "TODO"

  task run_bot: :environment do
    require 'cinch'

    class Cinch::Message
      def twitch(string)
        string = string.to_s.gsub('<','&lt;').gsub('>','&gt;')
        bot.irc.send ":#{bot.config.user}!#{bot.config.user}@#{bot.config.user}.tmi.twitch.tv PRIVMSG #{channel} :#{string}"
      end
    end 

    bot = Cinch::Bot.new do
      configure do |c|
        #c.server = 'card.freenode.net'
        #c.channels = ['#cinch-bots']
        c.server = 'irc.twitch.tv'
        #c.channels = ['#itsprayy']
        #c.channels = ['#shadowingx']
        #c.channels = ['#eggo614']
        c.channels = ['#tsm_theoddone']
        c.nick = 'itsprayy'
        c.user = 'itsprayy'
        c.password = Rails.application.secrets.twitch_oauth_token
      end

      on :message, 'hello' do |m|
        m.twitch "Hello, #{m.user.nick}"
      end

      on :message, '!info' do |m|
        m.twitch "I am an advanced form of intellect. Prepare thy anus"
      end

      on :connect do |m|
        bot.irc.send 'NAMES'
      end


    end

    bot.start



  end
end
