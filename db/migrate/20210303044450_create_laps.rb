class CreateLaps < ActiveRecord::Migration[6.1]
  def change
    create_table :laps do |t|
      t.integer :time
      t.integer :difference
      t.references :stopwatch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
