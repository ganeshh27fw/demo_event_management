class TicketTypesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :event
  load_and_authorize_resource :ticket_type, through: :event

  def new
    @ticket_type = @event.ticket_types.new
  end

  def create
    @ticket_type = @event.ticket_types.new(ticket_type_params)
    if @ticket_type.save
      redirect_to @event, notice: 'Ticket type was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @ticket_type.update(ticket_type_params)
      redirect_to @event, notice: 'Ticket type was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @ticket_type.destroy
    redirect_to @event, notice: 'Ticket type was successfully deleted.'
  end


  private

  def ticket_type_params
    params.require(:ticket_type).permit(:name, :price, :total_quantity, :available_quantity)
  end
end
