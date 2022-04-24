# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :source, class_name: 'Wallet', optional: true
  belongs_to :target, class_name: 'Wallet', optional: true
  belongs_to :user

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
    case self
    when Deposit
      wallet_ids = [target_id]
    when Withdraw
      wallet_ids = [source_id]
    when Transfer
      wallet_ids = [target_id, source_id]
    end

    return unless wallet_ids.present?

    Wallet.where(id: wallet_ids).each(&:calculation_total)
  end

  def check_ownership_and_total
    wallet_total = Wallet.select('total, user_id').find_by(id: source_id)
    if wallet_total.present? && total.to_f > wallet_total&.total.to_f
      errors.add(:total, "can't be greater than balance")
    end

    errors.add(:source, 'is not yours') unless wallet_total.user_id == user_id
  end
end
