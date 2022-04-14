class AddSignedToStudents < ActiveRecord::Migration[6.1]
  def change
    add_column :students, :signed, :boolean, :default => false
  end
end
