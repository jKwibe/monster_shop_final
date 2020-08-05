class Discount < ApplicationRecord
  validates_presence_of :discount, :amount
  validates :discount, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100}
  validates :amount, numericality: {only_integer: true, greater_than: 0}
  belongs_to :merchant

  def self.best_discounts(quantity)
    where('amount <= ?', quantity).order(discount: :desc).pluck(:discount).first
  end
end
