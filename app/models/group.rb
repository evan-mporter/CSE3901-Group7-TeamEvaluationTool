class Group < ApplicationRecord
  has_and_belongs_to_many :students
  has_many :feedback_items
end
