class Discount < ApplicationRecord
  validates_presence_of :discount, :amount
  belongs_to :merchant
  
end
