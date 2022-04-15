class AddSignedToInstructors < ActiveRecord::Migration[6.1]
  def change
    add_column :instructors, :signed, :boolean
  end
end
