class CreateIps < ActiveRecord::Migration[6.0]
  def change
    create_table :ips do |t|
      t.references :tenant, null: false, foreign_key: true
      t.string :content, null: false

      t.timestamps
    end
  end
end
