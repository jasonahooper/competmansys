class EventRegistrationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter do
    params[:event_registration] = event_registration_params if params[:event_registration]
  end
  load_and_authorize_resource

  def create
    @registration = EventRegistration.new(event_registration_params)
    @registration.competition_attendee_id = params[:competition_attendee_id]
    if @registration.save
      flash[:info] = "Registration recorded successfully."
    else
      flash[:alert] = "Error registering for the event. "
      flash[:alert] << @registration.errors.full_messages.join(". ")
    end
    # redirect_to competition_events_path(params[:competition_id])
    redirect_to competition_path(params[:competition_id])
  end

  def destroy
    @registration = EventRegistration.find(params[:id])
    if @registration.destroy
      flash[:info] = "Withdrawal recorded successfully."
    else
      flash[:alert] = "Error withdrawing from the event. "
      flash[:alert] << @registration.errors.full_messages.join(". ")
    end
    # redirect_to competition_events_path(params[:competition_id])
    redirect_to competition_path(params[:competition_id])
  end

  def update
    @event_registration = EventRegistration.find(params[:id])
    if @event_registration.update_attributes(event_registration_params)
      flash[:info] = "Registration updated successfully."
    else
      flash[:alert] = "Error updating registration!\n"
      flash[:alert] << @comp.errors.full_messages.join(".\n")
    end
    # redirect_to competition_events_path(params[:competition_id])
    redirect_to competition_path(params[:competition_id])
  end

  def edit
    @event_registration = EventRegistration.find(params[:id])
  end

  private
  def event_registration_params
    params.require(:event_registration).permit(:event_id, :competition_attendee_id,
      :result, :position)
  end
end
