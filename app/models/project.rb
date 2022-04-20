class Project < ApplicationRecord
  def feedback_for(group)
    group.feedback_for(self)
  end
end
