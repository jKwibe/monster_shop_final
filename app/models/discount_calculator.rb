class DiscountCalculator
    def initialize(discounts)
      @discounts = discounts
    end

    def discounts_selected(item_quantity)
        @discounts.min_by { |dis| (item_quantity - dis.amount).abs }.discount
    end

    def bulk_discount(item_quantity, total_amount)
        binding.pry
       (((100 - discounts_selected(item_quantity).to_f) / 100) * total_amount).round(2)
    end 

    def has_discount?(item_quantity)
        @discounts.all? do |dis|
            dis.quantity < item_quantity
        end
    end
    
end