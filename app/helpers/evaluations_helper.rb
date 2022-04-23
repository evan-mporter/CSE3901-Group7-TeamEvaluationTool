module EvaluationsHelper
  # Returns URL for the back button on all pages except for landing
  def back_btn_url
    member = params[:member].to_i
    if params[:action] == "done"
      continue_eval_url(member: @group.students.length - 1, dir: "back")
    elsif member == 0
      begin_eval_url(dir: "back")
    else
      continue_eval_url(member: member - 1, dir: "back")
    end
  end

  # Returns URL for the next button on all pages except for done
  def next_btn_url 
    member = params[:member].to_i
    if params[:action] == "landing"
      continue_eval_url(member: 0)
    elsif member < (@group.students.length - 1)
      continue_eval_url(member: member + 1)
    else
      done_eval_url
    end
  end

  # Helper function to make a single radio button for the
  # evaluations form
  def single_radio_helper(f, param, value, text)
    active = (@feedback_item[param] == value)
    """
      <label class=\"btn btn-outline-secondary #{active ? "active" : ""}\">
        #{f.radio_button param, value}
        #{text}
      </label>
    """.html_safe
  end
end
