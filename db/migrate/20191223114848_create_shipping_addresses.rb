class CreateShippingAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_addresses do |t|
      t.integer :postal_code,                     null: false   
      t.string :address,                          null: false
      t.string :building,                         null: false
      t.string :prefecture,                       null: false
      t.integer :telephone,                       null: false
      t.references :user,                         foreign_key: true
      t.timestamps
    end
  end
end
