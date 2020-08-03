class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|
      t.references :merchant, foreign_key: true
      t.integer :discount
      t.integer :amount

      t.timestamps
    end
  end
end
