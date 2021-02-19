class StopwatchesController < ApplicationController
  
  def index
    @stopwatches = Stopwatch.where(user_id: current_user.id)
  end

  def new
    @stopwatch = Stopwatch.new
  end

  def create
    @stopwatch = Stopwatch.new(stopwatch_params)
    if @stopwatch.save
      flash[:success]="Record of stopwatch saved"
    else 
      render :new
    end
  end

  def destroy
    @stopwatch = Stopwatch.find(params[:id])
    @stopwatch.destroy
    redirect_to root_path
  end

  private
  def stopwatch_params
    params.require(:stopwatch).permit(:label, :time, :user_id)
  end
end
