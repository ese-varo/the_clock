class AddDaysToAlarms < ActiveRecord::Migration[6.1]
  def change
    add_column :alarms, :days, :string
  end
end
