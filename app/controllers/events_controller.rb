class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [ :show, :index, :show_results ]
  before_filter do
    params[:event] = event_params if params[:event]
  end
  load_and_authorize_resource

  before_action do
    @comp = Competition.find(params[:competition_id])
  end

  def index
    @events = Competition.find(params[:competition_id]).events.order(:name)
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

  def entrants
    @event = Event.find(params[:event_id])
    @entrants = @event.entrants
  end

  def edit_results
    @event = Event.find(params[:event_id])
  end

  def show_results
    @event = Event.find(params[:event_id])
  end

  private
  def event_params
    params.require(:event).permit(:name, :description, :competition_id, :image,
      :event_registrations_attributes => [ :id , :result, :position ] )
  end
end
