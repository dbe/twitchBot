class ViewersController < ApplicationController
  before_action :set_viewer, only: [:show]

  def index
    @viewers = Viewer.order('points DESC')
    @viewers_by_broadcasts = Broadcast.group(:viewer).count.sort_by {|k,v| v}.reverse
  end

  def show
    @broadcasts = @viewer.broadcasts.all
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_viewer
      @viewer = Viewer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def viewer_params
      params.require(:viewer).permit(:name)
    end
end
