module EvaluationsHelper
  # Returns URL for the back button on all pages except for landing
  def back_btn_url
    member = params[:member].to_i
    if params[:action] == "done"
      continue_eval_path(member: @group.students.length - 1)
    elsif member == 0
      begin_eval_path
    else
      continue_eval_path(member: member - 1)
    end
  end

  # Returns URL for the next button on all pages except for done
  def next_btn_url
    member = params[:member].to_i
    if params[:action] == "landing"
      continue_eval_path(member: 0)
    elsif member < (@group.students.length - 1)
      continue_eval_path(member: member + 1)
    else
      done_eval_path
    end
  end

end
