class EventsController < ApplicationController
  before_action :authenticate_user!
   before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    if params[:query].present?
      @events = Event.where("name LIKE ? OR artists LIKE ? OR producer LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%","%#{params[:query]}%")
    else
      @events = Event.all
    end
  end

  #  def index
  #   if params[:query].present?
  #     @events = Event.search(params[:query]).records
  #   else
  #     @events = Event.all
  #   end
  # end

  # Other actions remain unchanged...

 
  def set_event
    @event = Event.find(params[:id])
  end

  

  def show
    @event = Event.find(params[:id])
    
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end



  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: 'You are not authorized to perform this action.'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to home_index_path, notice: 'Event was successfully deleted.'
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :date, :city, :producer, :artists, :image)
  end
end