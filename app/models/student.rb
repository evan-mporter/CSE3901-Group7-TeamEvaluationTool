class Student < ApplicationRecord
    has_secure_password

    has_and_belongs_to_many :groups
    
    has_many :feedback_items, dependent: :destroy, foreign_key: :target_id, inverse_of: :target
    has_many :authored_fb_items, class_name: :FeedbackItem, dependent: :nullify, foreign_key: :author_id, inverse_of: :author

    validates :name, presence: true, length: { maximum: 50 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

    VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\W]).{8,}\z/
    validates :password, presence: true, length: {minimum: 8}, format: { with: VALID_PASSWORD_REGEX, message: "must contain at least a lowercase and an uppercase letter, a digit, and a special char" }

    def feedback_for(proj, group)
        self.feedback_items.where(project: proj).filter{ |f| f.author.nil? or group.students.include? f.author }
    end
end
