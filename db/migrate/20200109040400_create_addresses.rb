class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|

      t.integer :postal_code,                     null: false, default: "00" 
      t.string :prefecture,                       null: false, default: ""
      t.string :city,                             null: false, default: ""
      t.string :address,                          null: false, default: ""
      t.string :building
      t.references :user,                         foreign_key: true
      t.timestamps
    end
  end
end
