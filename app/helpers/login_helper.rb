module LoginHelper

  # Student

  # Returns the Student object that's currently signed in, if any
  def current_student
    if session[:student_id]
      @current_student ||= Student.find_by(id: session[:student_id])
    end
  end

  # Make the provided Student object logged in
  def log_in_student student
    session[:student_id] = student.id
  end
  
  # Returns true if a student is logged in, false otherwise
  # If a student is provided, will only return true if that specific student is logged in
  def student_logged_in? (student = nil)
    (not current_student.nil?) and (student.nil? or current_student == student)
  end

  # Instructor
  
  # Returns the Instructor object that's currently signed in, if any
  def current_inst
    if session[:inst_id]
      @current_inst ||= Instructor.find_by(id: session[:inst_id])
    end
  end

  # Make the provided Instructor object logged in
  def log_in_instructor instructor
    session[:inst_id] = instructor.id
  end
  
  # Returns true if an instructor is logged in, false otherwise
  # If a instructor is provided, will only return true if that specific instructor is logged in
  def inst_logged_in? (instructor = nil)
    (not current_inst.nil?) and (instructor.nil? or current_inst == instructor)
  end

  # Shared

  # Returns true if anyone is logged in, false otherwise
  def logged_in?
    inst_logged_in? || student_logged_in?
  end
  
  # Logs out current instructor or student
  def log_out
    session.delete :student_id
    session.delete :inst_id
    @current_student = nil
    @current_inst = nil
  end
  
end
