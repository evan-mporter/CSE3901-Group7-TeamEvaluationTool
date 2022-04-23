class FeedbackItem < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: :Student, optional: true
  belongs_to :target, class_name: :Student

  validates :participation, presence: true,
    inclusion: { in: 1..5, message: "not in valid range" }

  validates :quality, presence: true,
    inclusion: { in: 1..5, message: "not in valid range" }

  validates :disagreements, presence: true,
    inclusion: { in: 1..5, message: "not in valid range" }

  validates :comments, presence: true
end
