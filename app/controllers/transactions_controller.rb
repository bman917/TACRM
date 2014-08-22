class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
    @transaction.air_booking = AirBooking.new
  end

  def create
  end

  def transaction_params
    params.require(:transaction).permit(:client_id, :name, :type_code, :status,
      :reference_number, :vendor_id, :agent_id, :air_booking_id)
  end
end