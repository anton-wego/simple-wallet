class WithdrawsController < ApplicationController
  before_action :check_source_wallet, only: :new

  def new
    @wd = Withdraw.new
    @user = User.first
    @wd.user = @user

  end

  def create
    @wd = Withdraw.new permit_params

    if @wd.valid?
      Withdraw.create_transaction permit_params
      redirect_to root_path, notice: "Withdraw to wallet : #{@wd.source.name} success"
    else
      @source_wallet = @wd.source
      flash.now[:alert] = "Withdraw to wallet #{@wd.source.name} failed"
      render :new
    end
  end


  protected
  def permit_params
    params.require(:withdraw).permit(:user_id, :source_id, :total)
  end

  def check_source_wallet
    @source_wallet = Wallet.find_by(id: params[:source_id])
    unless @source_wallet.present?
      redirect_to root_path, notice: "Source wallet not found"
    end
  end
end
