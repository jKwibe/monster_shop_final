require 'rails_helper'

RSpec.describe 'Merchant Discount' do
    describe 'As an employee of a merchant' do
        before :each do
        @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @merchant_2 = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @m_user = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
        @discount = @merchant_1.discounts.create(discount: 5, amount: 10)
        @discount2 = @merchant_1.discounts.create(discount: 2, amount: 5)
        @discount3 = @merchant_1.discounts.create(discount: 10, amount: 20)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)
        end

    it "can update discount" do
        
        visit merchant_dashboard_path
        within "#discount-#{@discount2.id}" do
          expect(page).to  have_content("2% discount for 5 items.")
        end
  
        within "#discount-#{@discount.id}" do
          expect(page).to  have_content("5% discount for 10 items.")
          expect(page).to  have_button("update")
          click_button "update"
        end
  
        expect(current_path).to  eq(edit_merchant_discount_path(@discount))
        expect(find_field(:discount).value).to  eq("5")
        expect(find_field(:amount).value).to  eq("10")
  
        fill_in :discount,	with: "3" 
        fill_in :amount,	with: "8"
        
        click_on "update discount"
  
        expect(current_path).to  eq(merchant_dashboard_path)
  
        within "#discount-#{@discount.id}" do
        #   expect(page).to  have_content("3% discount for 8 items.")
          expect(page).to  have_button("update")
        end
  
      end

      it "can rise errors if not filled correctly" do
          visit edit_merchant_discount_path(@discount)
          fill_in :discount,	with: "-1" 
          fill_in :amount,	with: "8"
          click_on "update discount"

          expect(current_path).to  eq(edit_merchant_discount_path(@discount))
          expect(page).to  have_content("Check inputs. The value should be bumbers greater than 0and less than 100 on discount.")
      end
      
    end
end