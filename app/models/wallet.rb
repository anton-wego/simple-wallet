# frozen_string_literal: true

class Wallet < ApplicationRecord
  def calculation_total
    transaction do
      deposit_total = Deposit.where(target_id: id).sum(:total)
      wd_total = Withdraw.where(source_id: id).sum(:total)

      # transfer in
      transfer_in = Transfer.where(target_id: id).sum(:total)

      # transfer out
      transfer_out = Transfer.where(source_id: id).sum(:total)

      update(total: (deposit_total - wd_total) + (transfer_in - transfer_out))
    end
  end
end
