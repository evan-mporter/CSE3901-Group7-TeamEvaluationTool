class RedoFeedbackItemForeignKeys < ActiveRecord::Migration[6.1]
  def change
    # Frustratingly, Rails seems to have broken its own state with a previous
    # migration. It migrated successfully, but now nothing works. So, I'm just
    # going to start over
    drop_table :feedback_items

    create_table :feedback_items do |t|
      t.references :project, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: false
      t.references :target, null: false, foreign_key: false
      t.integer :participation
      t.integer :quality
      t.integer :disagreements
      t.text :comments

      t.foreign_key :students, column: :author_id
      t.foreign_key :students, column: :target_id

      t.timestamps
    end

    #remove_foreign_key :feedback_items, column: :author_id
    #remove_foreign_key :feedback_items, column: :target_id
    #add_foreign_key :feedback_items, :students, column: :author_id
    #add_foreign_key :feedback_items, :students, column: :target_id
  end
end
