class Instructor < ApplicationRecord
    has_secure_password
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\W]).{8,}\z/
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
    validates :password, presence: true, length: {minimum: 8}, format: { with: VALID_PASSWORD_REGEX, message: 
        "Password must contains at least a lowercase letter, a uppercase, a digit, a special char and 8+ chars" }
end
