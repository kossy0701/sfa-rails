class CreateDailyReports < ActiveRecord::Migration[6.0]
  def change
    create_table :daily_reports do |t|
      t.references :user, null: false, foreign_key: true
      t.string :problem
      t.string :improvement
      t.string :consultation

      t.timestamps
    end
  end
end
