class AddTimeToAlarms < ActiveRecord::Migration[6.1]
  def change
    add_column :alarms, :time, :time
  end
end
