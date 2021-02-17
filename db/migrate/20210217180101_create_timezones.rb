class CreateTimezones < ActiveRecord::Migration[6.1]
  def change
    create_table :timezones do |t|
      t.string :name

      t.timestamps
    end
  end
end
