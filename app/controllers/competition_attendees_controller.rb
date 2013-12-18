class CompetitionAttendeesController < ApplicationController
  before_filter :authenticate_user!
  before_filter do
    params[:competition_attendee] = competition_attendee_params if params[:competition_attendee]
  end
  load_and_authorize_resource

  def create
    @attendee = CompetitionAttendee.new(competition_attendee_params)
    @attendee.competition_id = params[:competition_id]
    if @attendee.save
      flash[:info] = "Attendance recorded successfully."
      # redirect_to competitions_path
      redirect_to competition_path(params[:competition_id])
    else
      flash[:alert] = "Error recording attendance! "
      flash[:alert] << @attendee.errors.full_messages.join(". ")
      # redirect_to competitions_path
      redirect_to competition_path(params[:competition_id])
    end
  end

  def destroy
    @attendee = CompetitionAttendee.find(params[:id])
    if @attendee.destroy
      flash[:info] = "Non-attendance recorded successfully."
      redirect_to competitions_path
      # redirect_to competition_path(params[:competition_id])
    else
      flash[:alert] = "Error recording non-attendance! "
      flash[:alert] << @attendee.errors.full_messages.join(". ")
      redirect_to competitions_path
      # redirect_to competition_path(params[:competition_id])
    end
  end

  private
  def competition_attendee_params
    params.require(:competition_attendee).permit(:competition_id, :user_id)
  end
end
