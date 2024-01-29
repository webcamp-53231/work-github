class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :name, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.integer :shipping_cost, null: false, default: 500
      t.integer :total_payment, null: false
      t.integer :payment_method, null: false
      t.timestamps
    end
  end
end
