class BroadcastsController < ApplicationController

  def current
    @broadcast = Broadcast.current
  end

  def index
    @broadcasts = Broadcast.order('time DESC')
  end

  def show
    begin
      @broadcast = Broadcast.find(params[:id])

    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "Broadcast not found"
      redirect_to :root
    end
  end
end
