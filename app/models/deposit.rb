class Deposit < Transaction
  validates :target_id, presence: true
end
