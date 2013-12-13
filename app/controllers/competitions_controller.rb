class CompetitionsController < ApplicationController

  def index
    @comps = Competition.all
  end

  def new
    @comp = Competition.new(:user_id => current_user)
    @comp.events.new
  end

  def show
    @comp = Competition.find(params[:id])
  end

  def destroy
    @comp = Competition.find(params[:id])
    @comp.destroy!
    flash[:info] = "Competition destroyed successfully."
    redirect_to :action => "index"
  end

  def edit
    @comp = Competition.find(params[:id])
    @comp.events.new
  end

  def update
    @comp = Competition.find(params[:id])
    if @comp.update_attributes(competition_params)
      flash[:info] = "Competition updated successfully."
      redirect_to :action => "show", :id => @comp.id
    else
      flash[:alert] = "Error updating competition!\n"
      flash[:alert] << @comp.errors.full_messages.join(".\n")
      render :edit
    end
  end

  def create
    @comp = Competition.new(competition_params)
    @comp.user_id = current_user.id
    if @comp.save
      ca = CompetitionAdministrator.new(
        :competition_id => @comp.id, :user_id => current_user.id)
      ca.save!
      flash[:info] = "Competition created successfully."
      redirect_to :action => "show", :id => @comp.id
    else
      flash[:alert] = "Error creating competition!\n"
      flash[:alert] << @comp.errors.full_messages.join(".\n")
      render :new
    end
  end

  def find
  end

  private
  def competition_params
    params.require(:competition).permit(:name, :description, :start_date,
      :end_date, :image, :registration_close_date, :user_id, :location,
      :events_attributes => [:id, :name, :description])
  end
end
