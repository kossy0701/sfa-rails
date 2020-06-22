class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.datetime :contacted_at, null: false
      t.integer :way, null: false
      t.integer :purpose, null: false
      t.string :subject, null: false
      t.text :content, null: false
      t.integer :target, null: false

      t.timestamps
    end
  end
end
