class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.boolean :is_open

      t.timestamps
    end
  end
end
