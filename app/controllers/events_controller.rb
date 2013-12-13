class EventsController < ApplicationController

  before_action do
    @comp = Competition.find(params[:competition_id])
  end

  def index
    @events = Competition.find(params[:competition_id]).events
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy!
    flash[:info] = "Event destroyed successfully."
    redirect_to :action => "index"
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:info] = "Event updated successfully."
      redirect_to :action => "index"
    else
      flash[:alert] = "Error updating event! "
      flash[:alert] << @event.errors.full_messages.join(". ")
      render :edit
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.competition_id = params[:competition_id]
    if @event.save
      flash[:info] = "Event created successfully."
      redirect_to :action => "index"
    else
      flash[:alert] = "Error creating event! "
      flash[:alert] << @event.errors.full_messages.join(". ")
      render :new
    end
  end

  private
  def event_params
    params.require(:event).permit(:name, :description, :competition_id)
  end
end
