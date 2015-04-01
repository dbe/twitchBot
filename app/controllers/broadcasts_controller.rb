class BroadcastsController < ApplicationController
  def current
    @broadcast = Broadcast.current
  end

  def index
    @broadcasts = Broadcast.all
  end

  def show

  end
end
