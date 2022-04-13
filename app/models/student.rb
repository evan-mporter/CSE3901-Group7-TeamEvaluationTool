class Student < ApplicationRecord
    has_many :groups
    #Is this should be feedbackItems or feedbackitems or feedback_items?
    has_many :feedback_items
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
end
