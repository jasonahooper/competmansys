class EventRegistrationsController < ApplicationController

  def create
    @registration = EventRegistration.new(event_registration_params)
    @registration.competition_attendee_id = params[:competition_attendee_id]
    if @registration.save
      flash[:info] = "Registration recorded successfully."
    else
      flash[:alert] = "Error registering for the event. "
      flash[:alert] << @registration.errors.full_messages.join(". ")
    end
    redirect_to competition_events_path(params[:competition_id])
  end

  def destroy
    @registration = EventRegistration.find(params[:id])
    if @registration.destroy
      flash[:info] = "Withdrawal recorded successfully."
    else
      flash[:alert] = "Error withdrawing from the event. "
      flash[:alert] << @registration.errors.full_messages.join(". ")
    end
    redirect_to competition_events_path(params[:competition_id])
  end

  private
  def event_registration_params
    params.require(:event_registration).permit(:event_id, :competition_attendee_id)
  end
end
