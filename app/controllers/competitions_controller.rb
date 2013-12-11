class CompetitionsController < ApplicationController

  def new
    @comp = Competition.new(:user_id => current_user)
  end

  def create
    @comp = Competition.new(competition_params)
    @comp.user_id = current_user.id
    if @comp.save
      flash[:message] = "Competition created successfully."
      redirect_to :action => "show", :id => @comp.id
    else
      flash[:alert] = "Error creating competition!\n"
      flash[:alert] << @comp.errors.full_messages.join(".\n")
      render :new
    end
  end

  private
  def competition_params
    params.require(:competition).permit(:name, :description, :start_date,
      :end_date, :image, :registration_close_date, :user_id)
  end
end
