class CreateAlarms < ActiveRecord::Migration[6.1]
  def change
    create_table :alarms do |t|
      t.string :label
      t.string :time
      t.boolean :sende_email
      t.boolean :delete_after_goes_off
      t.boolean :repeat_days, array: true, default: []

      t.timestamps
    end
  end
end
