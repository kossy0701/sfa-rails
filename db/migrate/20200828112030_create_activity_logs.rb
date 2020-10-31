class CreateActivityLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_logs do |t|
      t.references :tenant, null: false, foreign_key: true
      t.text :action, null: false, comment: 'Behavior such as login is stored in json format.'
      t.string :performer, null: false, comment: 'Store polymorphic related class names.'
      t.string :performer_type, null: false, comment: 'Store polymorphic related class names.'
      t.string :ip_address, comment: 'store remote_ip address in Ipv4 format.'

      t.timestamps
    end

    add_index :activity_logs, :performer
    add_index :activity_logs, :performer_type
    add_index :activity_logs, :ip_address
  end
end
