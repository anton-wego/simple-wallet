# frozen_string_literal: true

class Deposit < Transaction
  validates :target_id, presence: true
end
