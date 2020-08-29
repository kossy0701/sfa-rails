class CreateActivityLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_logs do |t|
      t.references :tenant, null: false, foreign_key: true
      t.text :action, null: false
      t.string :performer, null: false
      t.string :performer_type, null: false
      t.string :ip_address

      t.timestamps
    end

    add_index :activity_logs, :performer
    add_index :activity_logs, :performer_type
    add_index :activity_logs, :ip_address
  end
end
