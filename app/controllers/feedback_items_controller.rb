class FeedbackItemsController < ApplicationController

  # GET /feedback_items/1
  def show
    # Only allow instructors to view feedback items
    return redirect_to login_path unless inst_logged_in?
    
    @feedback_item = FeedbackItem.find(params[:id])
  end

  # POST /feedback_items
  def update
    # Only allow a logged-in student to post feedback items
    return redirect_to login_path unless student_logged_in?
    
    # Handle form parameters
    form_params = params.require(:feedback_item).permit(:project_id,
      :target_id, :participation, :quality, :disagreements, :comments)
    form_params[:author_id] = current_student.id

    # Make sure we're not submitting to a closed project
    unless Project.find_by(id: form_params[:project_id])&.is_open
      flash[:danger] = "Form submitted successfully, but don't know where to redirect."
      return redirect_back fallback_location: root_path
    end

    # Try to find an existing FeedbackItem, if possible
    feedback_item = FeedbackItem.where(author_id: form_params[:author_id],
                                       target_id: form_params[:target_id],
                                       project_id: form_params[:project_id])
                                       .first
    feedback_item ||= FeedbackItem.new # Didn't find one

    if feedback_item.update(form_params)
      unless params[:continue_url].nil?
        redirect_to params[:continue_url]
      else
        flash[:success] = "Form submitted successfully, but don't know where to redirect."
        return redirect_back fallback_location: root_path
      end
    else
      # TODO: This is a gross hack, but it works. Oh well, it'll do
      flash[:feedback_items_error] = feedback_item.errors.full_messages
      return redirect_back fallback_location: root_path
    end
  end
end
