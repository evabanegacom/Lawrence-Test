class Api::V1::TransactsController < ApplicationController
  before_action :authorized
  def index
    @transacts = logged_in_user.transactions.all
    render json: @transacts
  end

  def add_money
    @user = logged_in_user
    @transact = logged_in_user.transactions.create(transact_params)
    @balance = @user.update_attribute(:global_balance, (logged_in_user.global_balance + @transact.incoming_transactions - @transact.outgoing_transactions))
    render json: { balance: @balance, user: logged_in_user, transact: @transact }, status: 200
  end

  def send_money
    @user = logged_in_user
    @transact = logged_in_user.transactions.create(transact_params)
    @balance = @user.update_attribute(:global_balance, (logged_in_user.global_balance - @transact.outgoing_transactions + @transact.incoming_transactions))
    render json: { balance: @balance, user: logged_in_user, transact: @transact }, status: 200
  end

  private

  def set_car
    @car = Car.find(params[:id])
  end

  def transact_params
    params.permit(:incoming_transactions, :outgoing_transactions)
  end
end
