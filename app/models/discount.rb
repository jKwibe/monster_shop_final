class Discount < ApplicationRecord
  validates_presence_of :discount, :amount
  belongs_to :merchant

  def self.best_discounts(quantity)
    where('amount <= ?', quantity).order(discount: :desc).pluck(:discount).first
  end
end
