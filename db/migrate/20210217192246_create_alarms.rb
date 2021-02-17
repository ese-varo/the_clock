class CreateAlarms < ActiveRecord::Migration[6.1]
  def change
    create_table :alarms do |t|
      t.string :label
      t.string :time
      t.boolean :sende_email
      t.boolean :delete_after_goes_off
      t.boolean :repeat_days, array: true, default: []
      # repeat_days is tought to store the symbols each [:monday, ... :sunday]
      # and evaluate repetition just in the stored days

      t.timestamps
    end
  end
end
