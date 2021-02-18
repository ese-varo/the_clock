class AddUserToTimezones < ActiveRecord::Migration[6.1]
  def change
    add_reference :timezones, :user, null: false, foreign_key: true
  end
end
