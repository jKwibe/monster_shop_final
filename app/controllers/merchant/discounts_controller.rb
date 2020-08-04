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

    def edit 
       @discount = Discount.find(params[:id])
    end

    def update
        discount = Discount.find(params[:id])
        if discount.update(discount_params)
            flash[:success] = 'Discount Updated'
            return redirect_to merchant_dashboard_path
        end

        flash[:error] = "Check inputs. The value should be bumbers greater than 0and less than 100 on discount."
        redirect_to edit_merchant_discount_path(discount)
    end

    def destroy
        discount = Discount.find(params[:id])
        discount.destroy
        flash[:success] = "Discount deleted"
        redirect_to merchant_dashboard_path
    end
    
    
    private
    def discount_params
        params.permit(:discount, :amount)
    end
    
    
    
end