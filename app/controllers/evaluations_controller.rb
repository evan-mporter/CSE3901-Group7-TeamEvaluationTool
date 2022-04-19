class EvaluationsController < ApplicationController
  include EvaluationsHelper
  
  before_action :set_props
  before_action :verify_login

  def landing
  end

  def single    
    # If the student is going to be reviewing themself, skip past this page
    if student_logged_in? @group.students[params[:member].to_i]
      unless params[:dir] == "back"
        return redirect_to next_btn_url
      else
        return redirect_to back_btn_url
      end
    end
  
    # Try to prefill w/ an existing feedback item, if possible
    @feedback_item = FeedbackItem.where(author_id: current_student.id,
                                        target_id: @target.id,
                                        project_id: @project.id)
                                        .first
    @feedback_item ||= FeedbackItem.new # Fallback to new item
  end

  def done
  end

  private
    def set_props
      @group = Group.find params[:group]
      @project = Project.find params[:project]
      @target = @group.students[params[:member].to_i] unless params[:member].nil?
    end
    
    def verify_login
      # Only let students view these pages...
      return redirect_to root_path unless student_logged_in?
      
      # As long as they are members of the group they're going to be reviewing
      unless @group.students.include? current_student
        return redirect_to student_path(current_student)
      end
      
      # If the project is closed, block an evaluation
      unless @project.is_open
        render 'project_closed'
      end
    end
end
