class Transaction < ApplicationRecord
  belongs_to :source, class_name: 'Wallet' , optional: true
  belongs_to :target, class_name: 'Wallet', optional: true

  validates :total, presence: true
  validates :total, numericality: { greater_than: 0 }

  def self.create_transaction(params)
    transaction do
      depo = new(params)
      depo.save
      depo.update_wallet

      depo
    end
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

  def check_ownership_and_total
    wallet_total = Wallet.select('total, user_id').find_by(id: source_id)
    if wallet_total.present? && total > wallet_total&.total.to_f
      errors.add(:total, "can't be greater than total of wallet")
    end

    unless wallet_total.user_id == self.user_id
      errors.add(:source, "is not yours")
    end
  end
end
