class StreamsController < ApplicationController
  before_action :set_viewer, only: [:show]

  def index
    @streams = Stream.all
  end

  def show
  end
end
