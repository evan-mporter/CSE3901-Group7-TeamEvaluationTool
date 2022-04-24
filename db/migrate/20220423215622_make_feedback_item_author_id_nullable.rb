class MakeFeedbackItemAuthorIdNullable < ActiveRecord::Migration[6.1]
  def change
    change_column_null :feedback_items, :author_id, true
  end
end
