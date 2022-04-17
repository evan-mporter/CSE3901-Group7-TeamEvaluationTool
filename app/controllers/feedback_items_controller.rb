class FeedbackItemsController < ApplicationController

  # GET /feedback_items/1
  def show
    @feedback_item = FeedbackItem.find(params[:id])
  end

  # POST /feedback_items
  def update
    form_params = params.require(:feedback_item).permit(:project_id,
      :target_id, :participation, :quality, :disagreements, :comments)
    form_params[:author_id] = 1 # TODO: current_student.id

    # Try to find an existing FeedbackItem, if possible
    feedback_item = FeedbackItem.where(author_id: form_params[:author_id],
                                       target_id: form_params[:target_id],
                                       project_id: form_params[:project_id])
                                       .first
    feedback_item = FeedbackItem.new if feedback_item.nil?

    #render html: form_params
    #return # TODO

    if feedback_item.update(form_params)
      unless params[:continue_url].nil?
        redirect_to params[:continue_url]
      else
        render html: "Feedback Submitted"
      end
    else
      flash[:danger] = "Failed to submit form: " + (feedback_item.errors.full_messages.join ", ")
      redirect_to request.referer # Go back to wherever the form was submitted
    end
  end

end
