class RemoveColumnTimeToAlarms < ActiveRecord::Migration[6.1]
  def change
    remove_column :alarms, :time, :datetime
  end
end
