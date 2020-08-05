require 'rails_helper'

RSpec.describe 'Merchant Discount Delete' do
    describe 'As an employee of a merchant' do
        before :each do
        @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @merchant_2 = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @m_user = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
        @discount = @merchant_1.discounts.create(discount: 5, amount: 10)
        @discount2 = @merchant_1.discounts.create(discount: 2, amount: 5)
        @discount3 = @merchant_1.discounts.create(discount: 10, amount: 20)

        visit "/login"
        fill_in :email,	with: 'megan@example.com' 
        fill_in :password,	with: 'securepassword'

        within 'form' do
          click_on "Log In"
        end
        end

    it "can delete discount" do
        
        visit merchant_dashboard_path

        within "#discount-#{@discount.id}" do
          expect(page).to  have_content("5% discount for 10 items.")
          expect(page).to  have_button("update")
          expect(page).to  have_button("delete")
        end
  
      end

      it "can rise errors if not filled correctly" do
          visit merchant_dashboard_path
          within "#discount-#{@discount.id}" do
            click_on "delete"
          end

          expect(current_path).to  eq(merchant_dashboard_path)

          expect(page).to have_content("Discount deleted")
          expect(page).to_not have_content("5% discount for 10 items.")   
      end
      
    end
end