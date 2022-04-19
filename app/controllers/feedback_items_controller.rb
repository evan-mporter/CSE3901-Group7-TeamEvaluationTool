class FeedbackItemsController < ApplicationController

  # GET /feedback_items/1
  def show
    # Only allow instructor to view
    return redirect_to login_path unless inst_logged_in?
    
    @feedback_item = FeedbackItem.find(params[:id])
  end

  # POST /feedback_items
  def update
    # Only allow a logged-in student to post
    return redirect_to login_path unless student_logged_in?
    
    # Handle form parameters
    form_params = params.require(:feedback_item).permit(:project_id,
      :target_id, :participation, :quality, :disagreements, :comments)
    form_params[:author_id] = current_student.id

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
        render html: "Feedback Submitted"
      end
    else
      flash[:danger] = "Failed to submit form: " + (feedback_item.errors.full_messages.join ", ")
      redirect_back_or_to root_path # Go back to wherever the form was submitted
    end
  end

end
