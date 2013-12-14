class CompetitionAttendeesController < ApplicationController
  def create
    @attendee = CompetitionAttendee.new(competition_attendee_params)
    if @attendee.save
      flash[:info] = "Attendance recorded successfully."
      redirect_to competitions_path
    else
      flash[:alert] = "Error recording attendance! "
      flash[:alert] << @attendee.errors.full_messages.join(". ")
      redirect_to competitions_path
    end
  end

  private
  def competition_attendee_params
    params.require(:competition_attendee).permit(:competition_id, :user_id)
  end
end
