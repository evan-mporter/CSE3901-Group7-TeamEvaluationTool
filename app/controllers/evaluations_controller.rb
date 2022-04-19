class EvaluationsController < ApplicationController
  before_action :set_props

  def landing
    return redirect_to
  end

  def single
    # Try to look up an existing feedback item
    @feedback_item = FeedbackItem.where(author_id: current_student.id,
                                        target_id: @target.id,
                                        project_id: @project.id)
                                        .first

    # Fallback to new item
    @feedback_item = FeedbackItem.new if @feedback_item.nil?
  end

  def done
  end

  private
    def set_props
      @group = Group.find params[:group]
      @project = Project.find params[:project]
      @target = @group.students[params[:member].to_i] unless params[:member].nil?
    end
end
