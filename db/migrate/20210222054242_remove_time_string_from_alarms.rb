class RemoveTimeStringFromAlarms < ActiveRecord::Migration[6.1]
  def change
    remove_column :alarms, :time, :string
  end
end
