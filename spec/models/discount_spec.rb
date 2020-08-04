require 'rails_helper'

RSpec.describe Discount do
    describe 'Relationships' do
        it { should belong_to(:merchant) } 
    end

    describe "validations" do
        it { should validate_presence_of(:discount) }
        it { should validate_presence_of(:amount) }
    end
    describe "methods" do
        before :each do
            @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
            @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
            @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
            @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 12 )
            @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 30 )
    
            @discount_1 = @megan.discounts.create(discount: 2, amount: 5)
            @discount_2 = @megan.discounts.create(discount: 5, amount: 10)
            @discount_3 = @megan.discounts.create(discount: 10, amount: 20)

    
          end
          it '.best_discounts(quantity)' do
             bulk_discount = @megan.discounts.best_discounts(11)
             bulk_discount2 = @megan.discounts.best_discounts(4)
             bulk_discount3 = @megan.discounts.best_discounts(6)
             bulk_discount4 = @megan.discounts.best_discounts(30)
            
             expect(bulk_discount).to eq(5)
             expect(bulk_discount2).to eq(nil)
             expect(bulk_discount3).to eq(2)
             expect(bulk_discount4).to eq(10)
           end
        
    end
    
end