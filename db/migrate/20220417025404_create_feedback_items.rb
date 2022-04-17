class CreateFeedbackItems < ActiveRecord::Migration[6.1]
  def change
    create_table :feedback_items do |t|
      t.references :project, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true
      t.references :target, null: false, foreign_key: true
      t.integer :participation
      t.integer :quality
      t.integer :disagreements
      t.text :comments

      t.timestamps
    end
  end
end
