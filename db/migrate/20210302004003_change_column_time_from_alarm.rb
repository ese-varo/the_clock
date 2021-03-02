class ChangeColumnTimeFromAlarm < ActiveRecord::Migration[6.1]
  def change
    change_column :alarms, :time, :time
  end
end
