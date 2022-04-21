module ApplicationHelper

  # Helps construct the navbar
  def nav_item(name, icon, controller, path, method="get")

    active = (params[:controller] == controller)
    if (inst_logged_in? and (request.fullpath == instructor_path(current_inst))) or
       (student_logged_in? and (request.fullpath == student_path(current_student)))
      active = (controller == "home")
    end
    active = active ? "active" : ""

    child = "<i class=\"fa fa-#{icon}\" aria-hidden=\"true\"></i> #{name}".html_safe
    link_to child, path, class: "nav-item nav-link text-center px-3 #{active}", method: method
  end

end
