# frozen_string_literal: true

class Transfer < Transaction
  validates :target_id, :source_id, presence: true

  validate :check_ownership_and_total
end
