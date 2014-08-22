class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
    @transaction.air_booking = AirBooking.new

  end

  def create
    transaction = Transaction.new(transaction_params)
    transaction.air_booking = AirBooking.new(air_booking_params)
    transaction.save

    client = Profile.find(transaction.client_id)
    redirect_to profile_path(id: client.id, panel_number: client.transactions_liquid_slider_panel_number)

  end

  def transaction_params
    params.require(:transaction).permit(:client_id, :name, :type_code, :status,
      :reference_number, :vendor_id, :agent_id, :air_booking_id)
  end

  def air_booking_params
    params2 = ActionController::Parameters.new(air_booking: params[:transaction])
    params2.require(:air_booking).permit(:destination_code, :arrival_date, :return_date)
  end
end