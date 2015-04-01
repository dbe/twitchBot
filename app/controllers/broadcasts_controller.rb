class BroadcastsController < ApplicationController
  def index
    @broadcast = Broadcast.current
  end
end
