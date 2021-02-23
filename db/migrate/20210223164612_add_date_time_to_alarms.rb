class AddDateTimeToAlarms < ActiveRecord::Migration[6.1]
  def change
    add_column :alarms, :time, :datetime
  end
end
