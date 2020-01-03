class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string     :name,          null: false
      t.text       :description,   null: false
      t.string     :condition,     null: false
      t.string     :shipping_fee,  null: false
      t.string     :shipping_how,  null: false
      t.string     :shipping_from, null: false
      t.string     :shipping_date, null: false
      t.integer    :price,         null: false
      t.integer    :likes_count,   default: 0
      t.references :user,          foregin_key: true
      t.references :customer,      foregin_key: true
      t.references :category,      foregin_key: true
      t.references :size,          foregin_key: true
      t.references :brand,         foregin_key: true
      t.timestamps
    end
  end
end
