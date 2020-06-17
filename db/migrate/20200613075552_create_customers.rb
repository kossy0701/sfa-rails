class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.integer :contract_status, default: 0, null: false
      t.string :name, default: '', null: false
      t.string :postal_code, default: ''
      t.integer :prefecture_id, null: false
      t.string :city, null: false
      t.string :address1, null: false
      t.string :address2

      t.timestamps
    end

    add_index :customers, :contract_status
    add_index :customers, :name
    add_index :customers, :prefecture_id
  end
end
