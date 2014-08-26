class TransactionsController < ApplicationController

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    respond_to do | format |
      format.html { redirect_to_profile_page(@transaction) }
      format.js
    end
  end

  def new
    @transaction = Transaction.new
    @transaction.air_booking = AirBooking.new

    respond_to do | format |
      format.html 
      format.js
    end

  end

  def create
    transaction = Transaction.new(transaction_params)
    transaction.air_booking = AirBooking.new(air_booking_params)
    transaction.save

    redirect_to_profile_page(transaction)
  end

  def transaction_params
    params.require(:transaction).permit(:client_id, :name, :type_code, :status,
      :reference_number, :vendor_id, :agent_id, :air_booking_id)
  end

  def air_booking_params
    params2 = ActionController::Parameters.new(air_booking: params[:transaction])
    params2.require(:air_booking).permit(:destination_code, :arrival_date, :return_date)
  end

  private

  def redirect_to_profile_page(transaction)
    client = Profile.find(transaction.client_id)
    redirect_to profile_path(id: client.id, panel_number: client.transactions_liquid_slider_panel_number)
  end
end