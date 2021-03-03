class StopwatchesController < ApplicationController
  
  def index
    @stopwatches = current_user.stopwatches
    respond_to do |format|
      format.html
      format.json { render json: @stopwatches}
    end
  end

  def show
    @stopwatch = Stopwatch.find(params[:id])
  end

  def create
    @stopwatch = current_user.stopwatches.create(stopwatch_params)
    if @stopwatch
      @stopwatch.laps.create(stopwatch_lap_params)
      render json: @stopwatch
    else 
      render :new
    end
  end

  def update
    @stopwatch = Stopwatch.find(params[:id])
    @lap = @stopwatch.laps.create(stopwatch_lap_params)
    if @lap
      @stopwatches = current_user.stopwatches
    else
      render :new
    end
  end

  def destroy
    @stopwatch = current_user.stopwatches.find(params[:id])
    @stopwatch.destroy
  end

  private
  def stopwatch_params
    params.require(:stopwatch).permit(:label)
  end

  def stopwatch_lap_params
    params.permit(:time, :difference)
  end
end
