namespace :tb do

  desc "TODO"

  task run_bot: :environment do
    require 'cinch'

    bot = Cinch::Bot.new do
      configure do |c|
        c.server = 'card.freenode.net'
        c.channels = ['#cinch-bots']
      end

      on :message, 'hello' do |m|
        m.reply "Hello, #{m.user.nick}"
      end
    end

    bot.start



  end
end
