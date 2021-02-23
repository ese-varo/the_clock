class RemoveTimeToAlarms < ActiveRecord::Migration[6.1]
  def change
    remove_column :alarms, :time, :time
  end
end
