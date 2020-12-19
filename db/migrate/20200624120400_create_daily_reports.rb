class CreateDailyReports < ActiveRecord::Migration[6.0]
  def change
    create_table :daily_reports do |t|
      t.references :user, null: false, foreign_key: true
      t.string :problem
      t.string :improvement
      t.string :consultation
      t.integer :status, null: false, default: 1

      t.timestamps
    end
  end
end
