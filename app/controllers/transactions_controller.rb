class TransactionsController < ApplicationController

  def update
    @transaction = get_transaction
    @transaction.update(transaction_params)
    @transaction.air_booking.update(air_booking_params)
    

    respond_to do | format |
      format.html { redirect_to_profile_page(@transaction) }
      format.js { render 'reload'}
    end
  end

  def edit
    @transaction = get_transaction
  end

  def destroy
    @transaction = get_transaction
    @transaction.destroy
    respond_to do | format |
      format.html { redirect_to_profile_page(@transaction) }
      format.js { render 'reload'}
    end
  end

  def new
    @profile = Profile.find(params[:profile_id]) if params[:profile_id]
    @transaction = Transaction.new
    @transaction.client = @profile
    @transaction.air_booking = AirBooking.new

    respond_to do | format |
      format.html 
      format.js
    end

  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.air_booking = AirBooking.new(air_booking_params)
    @transaction.save
    @transactions = @transaction.client.transactions
    respond_to do | format |
      format.html { redirect_to_profile_page(@transaction) }
      format.js { render 'reload'}
    end

    
  end

  def transaction_params
    params.require(:transaction).permit(:id, :client_id, :name, :type_code, :status,
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

  def get_transaction
    @transaction = Transaction.find(params[:id])
    @transactions = @transaction.client.transactions
    @profile = @transaction.client
    return @transaction
  end
end