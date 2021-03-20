class StopwatchesController < ApplicationController
  
  def index
    @stopwatches = current_user.stopwatches
    respond_to do |format|
      format.html
      format.json { render json: @stopwatch }
    end
  end

  def show
    @stopwatch = Stopwatch.find(params[:id])
  end

  def create
    @stopwatch = current_user.stopwatches.create(stopwatch_params)
    if @stopwatch.valid?
      @stopwatch.laps.create(stopwatch_lap_params)
      flash[:success] = 'Stopwatch created successfully, starting to record laps'
      render json: @stopwatch
    else
      shows_errors(@stopwatch.errors)
      redirect_to user_stopwatches_path(current_user)
    end
  end

  def update
    @stopwatch = Stopwatch.find(params[:id])
    @lap = @stopwatch.laps.create(stopwatch_lap_params)
    if @lap.valid?
      @stopwatches = current_user.stopwatches
    else
      shows_errors(@lap.errors)
      redirect_to user_stopwatches_path(current_user)
    end
  end

  def destroy
    @stopwatch = current_user.stopwatches.find(params[:id])
    @stopwatch.destroy
    if @stopwatch.valid?
      flash[:success] = 'Stopwatch deleted successfully'
      redirect_to user_stopwatches_path(current_user)
    end
  end

  private
  def stopwatch_params
    params.require(:stopwatch).permit(:label)
  end

  def stopwatch_lap_params
    params.permit(:time, :difference)
  end
  
  def shows_errors(errors)
    errors.full_messages.each do |error|
      flash[:danger] = error
    end
  end
end
