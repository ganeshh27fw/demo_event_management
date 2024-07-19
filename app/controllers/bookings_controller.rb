class BookingsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: :history

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @ticket_type = TicketType.find(params[:booking][:ticket_type_id])
    @quantity = params[:booking][:quantity].to_i

    if @quantity > 0 && @quantity <= @ticket_type.available_quantity
      Booking.transaction do
        @ticket_type.available_quantity -= @quantity
        @ticket_type.save!
        @booking.save!
        update_booking_cache(current_user)
                         
      end
       


      TicketConfirmationJob.perform_later(current_user, @booking)

      redirect_to @booking.event, notice: 'Booking was successfully created.'
    else
      redirect_to @booking.event, alert: 'Unable to create booking. Invalid quantity.'
    end
  end

  def history
    x = Rails.cache.fetch("user_#{current_user.email}_bookings")
    puts('vvvvvvvv',x.to_yaml)
    @bookings = Rails.cache.fetch("user_#{current_user.email}_bookings") do current_user.bookings.includes(:event, :ticket_type).order(created_at: :desc) end
  end

  def cancel
    @booking = current_user.bookings.find(params[:id])
    @ticket_type = @booking.ticket_type

    Booking.transaction do
      @ticket_type.available_quantity += @booking.quantity
      @ticket_type.save!
      @booking.destroy!
      update_booking_cache(current_user)
    end
    redirect_to booking_history_path, alert: 'Booking was successfully canceled.'
  end

  def update_booking_cache(user)
    bookings = user.bookings.includes(:event, :ticket_type).order(created_at: :desc)
    Rails.cache.write("user_#{current_user.email}_bookings", bookings)
  end

  private

  def booking_params
    params.require(:booking).permit(:event_id, :ticket_type_id, :quantity)
  end
end
