class BroadcastsController < ApplicationController

  def current
    @broadcast = Broadcast.current
  end

  def index
    @broadcasts = Broadcast.order('time DESC')

    if(params[:viewer_id])
      @broadcasts = @broadcasts.where(:viewer => params[:viewer_id])
    end

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
