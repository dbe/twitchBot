class StreamsController < ApplicationController
  def index
    @streams = Stream.all
  end

  def show
  end
end
