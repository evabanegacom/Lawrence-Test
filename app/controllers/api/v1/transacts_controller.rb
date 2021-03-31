class Api::V1::TransactsController < ApplicationController
    def index
      @transacts = logged_in_user.transactions.all
      render json: @transacts
    end

    def add_money
      @user_balance = logged_in_user.global_balance
      @transact = logged_in_user.transactions.create(transact_params)
      @user_balance = @user_balance + @transact.incoming_transactions
      render json: { balance: @user_balance, user: logged_in_user, transact: @transact }, status: 200
    end

    def send_money
      @transact = logged_in_user.transactions.create(transact_params)
      @balance = logged_in_user.global_balance - @transact.outgoing_transactions
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