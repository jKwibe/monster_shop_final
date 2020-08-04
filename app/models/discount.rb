class Discount < ApplicationRecord
  validates_presence_of :discount, :amount
  belongs_to :merchant

  def self.selected_discounts(item_quantity)
    
    binding.pry
    
  end
  
end
