class CreateAlarmDays < ActiveRecord::Migration[6.1]
  def change
    create_table :alarm_days do |t|
      t.datetime :daytime
      t.references :alarm, null: false, foreign_key: true

      t.timestamps
    end
  end
end
