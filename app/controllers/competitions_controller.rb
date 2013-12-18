class CompetitionsController < ApplicationController
  before_filter :authenticate_user!, :except => [ :find, :search, :show, :index ]
  before_filter do
    params[:competition] = competition_params if params[:competition]
  end
  load_and_authorize_resource

  def index
    @comps = Competition.all
  end

  def new
    @comp = Competition.new(:user_id => current_user)
    @comp.events.new
  end

  def show
    @comp = Competition.find(params[:id])
    @marker = Gmaps4rails.build_markers(@comp) do |comp, marker|
      marker.lat comp.latitude
      marker.lng comp.longitude
      marker.infowindow comp.description
    end
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
    @locations = ['where I am now']
    @locations << ['my home address'] if signed_in? && current_user.latitude
  end

  def search
    if params[:distance]
      if params[:from] == 'where I am now'
        lat = request.location.latitude
        lng = request.location.longitude
      elsif params[:from] == "my home address"
        lat = current_user.latitude
        lng = current_user.longitude
      end
      @comps = Competition.miles_from(lat, lng, params[:distance])
    elsif params[:keywords]
      @comps = Competition.keywords(params[:keywords])
    elsif params[:start_date]
      if params[:end_date] && params[:end_date] > params[:start_date]
        @comps = Competition.between(params[:start_date], params[:end_date])
      else
        @comps = Competition.after(params[:start_date])
      end
    end
    render 'index'
  end

  def attendees
    @comp = Competition.find(params[:competition_id])
    @attendees = @comp.attendees
  end

  private
  def competition_params
    params.require(:competition).permit(:name, :description, :start_date,
      :end_date, :image, :registration_close_date, :user_id, :location,
      :justgiving_id, :events_attributes => [:id, :name, :description])
  end
end
