class CompetitionsController < ApplicationController

  def create
    comp = Competition.new(competition_params)
    comp.save!
  end

  private
  def competition_params
    params.require(:competition).permit(:name, :description, :start_date,
      :end_date, :image, :registration_close_date, :user_id)
  end
end
