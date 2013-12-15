class CompetitionAttendeesController < ApplicationController
  def create
    @attendee = CompetitionAttendee.new(competition_attendee_params)
    @attendee.competition_id = params[:competition_id]
    if @attendee.save
      flash[:info] = "Attendance recorded successfully."
      redirect_to competitions_path
    else
      flash[:alert] = "Error recording attendance! "
      flash[:alert] << @attendee.errors.full_messages.join(". ")
      redirect_to competitions_path
    end
  end

  def destroy
    @attendee = CompetitionAttendee.find(params[:id])
    if @attendee.destroy
      flash[:info] = "Non-attendance recorded successfully."
      redirect_to competitions_path
    else
      flash[:alert] = "Error recording non-attendance! "
      flash[:alert] << @attendee.errors.full_messages.join(". ")
      redirect_to competitions_path
    end
  end

  private
  def competition_attendee_params
    params.require(:competition_attendee).permit(:competition_id, :user_id)
  end
end
