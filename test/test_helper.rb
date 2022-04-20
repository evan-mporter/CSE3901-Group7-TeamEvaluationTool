ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def is_instructor_logged_in?
    !session[:inst].nil?
  end

  def log_in_instructor instructor
    session[:inst] = instructor.id
  end

  def is_student_logged_in?
    !session[:inst].nil?
  end

  def log_in_student student
    session[:student] = student.id
  end
  
end
