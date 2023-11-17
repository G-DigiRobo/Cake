class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :order_id,                   null: false, default: ""
      t.integer :item_id,                    null: false, default: ""
      t.integer :tax_included_price,         null: false, default: ""
      t.integer :amount,                     null: false, default: ""
      t.integer :status,                     null: false, default: "0"

      t.timestamps
    end
  end
end
