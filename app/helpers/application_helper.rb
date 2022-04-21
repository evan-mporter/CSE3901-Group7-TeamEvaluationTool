module ApplicationHelper

  def nav_item name, icon, controller, path, method="get"
    child = "<i class=\"fa fa-#{icon}\" aria-hidden=\"true\"></i> #{name}".html_safe

    if controller == "home"
      if inst_logged_in?
        active = (request.fullpath == instructor_path(current_inst))
      elsif student_logged_in?
        active = (request.fullpath == student_path(current_student))
      else
        active = (params[:controller] == "application")
      end
    else
      active = (params[:controller] == controller)
    end
    active = active ? "active" : ""
    
    link_to child, path, class: "nav-item nav-link text-center px-3 #{active}", method: method
  end

end
