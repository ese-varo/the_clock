class RemoveTimeFromStopwatches < ActiveRecord::Migration[6.1]
  def change
    remove_column :stopwatches, :time, :string
  end
end
