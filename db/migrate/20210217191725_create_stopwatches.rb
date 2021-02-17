class CreateStopwatches < ActiveRecord::Migration[6.1]
  def change
    create_table :stopwatches do |t|
      t.string :label
      t.string :time

      t.timestamps
    end
  end
end
