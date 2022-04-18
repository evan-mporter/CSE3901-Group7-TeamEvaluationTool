module LoginHelper
   
 #TODO: Complete these helper methods  
 def is_student_logged_in?
    !session[:current_student].nil?     
 end

 def current_student
    session[:current_student]
 end

 def log_in_student student
    session[:current_student] = student[:id]
 end

 def is_inst_logged_in?
    !session[:current_inst].nil?
 end

 def current_inst
    session[:current_inst]
 end

 def log_in_instructor instructor
    session[:current_inst] = instructor[:id]
 end

 def is_logged_in?
    is_inst_logged_in? || is_student_logged_in?
 end

 def log_out
    if is_inst_logged_in?
        session[:current_inst] = nil
    elsif is_student_logged_in?
        session[:current_student] = nil
    end
 end

 def session_check instructor
   if session[:current_inst] = instructor[:id]
      session[:current_inst] = nil
   end
 end
end