class FeedbackItemsController < ApplicationController
  before_action :set_feedback_item, only: %i[ show edit update destroy ]

  # GET /feedback_items/1
  def show
  end

  # POST /feedback_items
  def update
    @feedback_item = FeedbackItem.find(params[:id])

    @feedback_item = FeedbackItem.new
    respond_to do |format|
      if @feedback_item.update(feedback_item_params)
        format.html { redirect_to feedback_item_url(@feedback_item), notice: "Feedback item was successfully updated." }
        format.json { render :show, status: :ok, location: @feedback_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @feedback_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback_item
      @feedback_item = FeedbackItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def feedback_item_params
      params.require(:feedback_item).permit(:project_id, :author_id, :target_id, :participation, :quality, :disagreements, :comments)
    end
end
