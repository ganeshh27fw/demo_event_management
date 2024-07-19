
class TicketConfirmationJob < ApplicationJob

  queue_as :mailers

  def perform(user, booking)
    puts('sdfessssssss ', user.to_yaml, booking.to_yaml)
     pdf = WickedPdf.new.pdf_from_string(
      ApplicationController.renderer.render(
        template: 'bookings/ticket_details.pdf.erb',
        locals: { booking: booking }
      )
    )


    UserMailer.ticket_confirmation_email(user, booking, pdf).deliver_now
  end
end
