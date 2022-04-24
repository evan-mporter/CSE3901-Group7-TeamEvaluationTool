class Group < ApplicationRecord
  has_and_belongs_to_many :students, validate: false
  has_many :feedback_items, through: :students

  validates :name, presence: true, length: { maximum: 50 }

  def feedback_for(proj)
    self.feedback_items.where(project: proj)
  end
end
