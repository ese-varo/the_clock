class StopwatchesController < ApplicationController
  
  def index
  end

  def new
    @minutes = 0
    @seconds = 0
  end

end
