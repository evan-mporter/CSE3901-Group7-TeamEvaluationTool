class AddDefaultToSigned < ActiveRecord::Migration[6.1]
  def change
    change_column :instructors, :signed, :boolean, default: false
  end
end
