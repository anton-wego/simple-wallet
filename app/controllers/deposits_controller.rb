class DepositsController < ApplicationController
  before_action :check_target_wallet, only: :new

  def new
    @deposit = Deposit.new
    @user = User.first
    @deposit.user = @user

  end

  def create
    @deposit = Deposit.new permit_params

    if @deposit.valid?
      Deposit.create_transaction permit_params
      redirect_to root_path, notice: "Deposit to wallet : #{@deposit.target.name} success"
    else
      flash.now[:alert] = "Deposit to wallet #{@deposit.target.name} failed"
      render :new
    end
  end


  protected
  def permit_params
    params.require(:deposit).permit(:user_id, :target_id, :total)
  end

  def check_target_wallet
    @target_wallet = Wallet.find_by(id: params[:target_id])
    unless @target_wallet.present?
      redirect_to root_path, notice: "Target walet not found"
    end
  end
end
