class StopwatchesController < ApplicationController
  
  def index
    @stopwatches = current_user.stopwatches
  end

  def new
    @stopwatch = Stopwatch.new
  end

  def create
    @stopwatch = current_user.stopwatches.create(stopwatch_params)
    if @stopwatch
      flash[:success]="Record of stopwatch saved"
    else 
      render :new
    end
  end

  def destroy
    @stopwatch = current_user.stopwatches.find(params[:id])
    @stopwatch.destroy
    redirect_to root_path
  end

  private
  def stopwatch_params
    params.require(:stopwatch).permit!
  end
end
