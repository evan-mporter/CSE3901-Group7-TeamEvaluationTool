class Project < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }

  def feedback_for(group)
    group.feedback_for(self)
  end
end
