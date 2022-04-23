class Transaction < ApplicationRecord
  belongs_to :source, class_name: 'Wallet' , optional: true
  belongs_to :target, class_name: 'Wallet', optional: true

  def self.create_transaction(params)
    depo = new(params)
    depo.save
    depo.update_wallet
  end

  def update_wallet
    if self.is_a?(Deposit)
      wallet_ids = [self.target_id]
    elsif self.is_a?(Withdraw)
      wallet_ids =  [self.source_id]
    elsif self.is_a?(Transfer)
      wallet_ids = [self.target_id, self.source_id]
    end

    if wallet_ids.present?
      Wallet.where(id: wallet_ids).each do |w|
        w.calculation_total
      end
    end
  end
end
