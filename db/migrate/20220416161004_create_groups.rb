class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.reference :students
      t.reference :feedback_items

      t.timestamps
    end
  end
end
