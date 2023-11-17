class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id,              null: false
      t.string :name,                   null: false
      t.text :detail,                   null: false
      t.integer :price,                 null: false
      t.boolean :is_sales_status,       null: false, default: true

      t.timestamps
    end
  end
end
