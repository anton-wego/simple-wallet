class TransfersController < ApplicationController
  before_action :prepulate_data
  before_action :check_source_wallet, only: :new

  def new
    @tf = Transfer.new
    @user = User.first
    @tf.user = @user
  end

  def create
    @tf = Transfer.new permit_params

    if @tf.valid?
      Transfer.create_transaction permit_params
      redirect_to root_path, notice: "Withdraw to wallet : #{@tf.source.name} success"
    else
      @source_wallet = @tf.source
      @wallets = @wallets.where.not(id: @source_wallet)
      flash.now[:alert] = "Withdraw to wallet #{@tf.source.name} failed"
      render :new
    end
  end


  protected
  def permit_params
    params.require(:transfer).permit(:user_id, :source_id, :target_id, :total)
  end

  def check_source_wallet
    @source_wallet = Wallet.find_by(id: params[:source_id])
    unless @source_wallet.present?
      redirect_to root_path, notice: "Source wallet not found"
    end
  end

  def prepulate_data
    @wallets = Wallet.select('id,name').where.not(id: params[:source_id])
  end
end
