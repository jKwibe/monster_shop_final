class Merchant::DiscountsController  < Merchant::BaseController
    def new
        
    end

    def create
        discount = current_user.merchant.discounts.new(discount_params)
        if discount.save
           flash[:sucess] = "Discount has been created." 
           return redirect_to merchant_dashboard_path
        end
        redirect_to new_merchant_discount_path
        flash[:error] = "Discount was not created sucessfully. Check on your input." 
    end

    private
    def discount_params
        params.permit(:discount, :amount)
    end
    
    
    
end