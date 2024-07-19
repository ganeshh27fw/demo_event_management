class HomeController < ApplicationController
  def index
    puts('params ', params)
    search_str = params[:query]
    if params[:query].present?
      @events = Event.where('date >= ?', Date.today).merge(Event.where("name LIKE ? OR artists LIKE  ? OR producer LIKE ? ", "%#{params[:query]}%", "%#{params[:query]}%,", "%#{params[:query]}%"))
        @comp_events = Event.where('date < ?', Date.today).merge(Event.where("name LIKE ? OR artists LIKE  ? OR producer LIKE ? ", "%#{params[:query]}%", "%#{params[:query]}%,", "%#{params[:query]}%"))
       else
      @events = Event.where('date >= ?', Date.today)
      @comp_events = Event.where('date < ?', Date.today)
    end

    
  end

  
  # def index
  #    @events = params[:query].present? ? Event.search(params[:query]).records : Event.all

  #   respond_to do |format|
  #     format.html
  #     format.json { render json: @events }
  #   end
  # end
end
