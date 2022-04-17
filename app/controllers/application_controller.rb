class ApplicationController < ActionController::Base
  include LoginHelper

  def root
    # Must be a new instance! There are no instructors. Prompt to make one
    if Instructor.count.zero?
      redirect_to new_instructor_url

    # An instructor is logged in. Redirect to their homepage
    elsif is_inst_logged_in?
      redirect_to instructor_url(current_inst)

    # A student is logged in. Redirect to their homepage
    elsif is_student_logged_in?
      redirect_to student_url(current_student)

    # Nobody is logged in. Redirect to the login page
    else
      redirect_to login_url
    end
  end

  def login
  end

  def full_reset
  end

  def do_full_reset
    if params[:key] == '0c90301e-0b89-4840-b42b-0a86d3eef8d4'
      # https://stackoverflow.com/a/69955217
      Rails.application.eager_load! unless Rails.application.config.eager_load
      ApplicationRecord.descendants.each { |model| model.delete_all }

      flash[:success] = "Database dropped!"
      redirect_to root_url
    else
      flash.now[:danger] = 'Incorrect Key!'
      render :full_reset
    end
  end
end
