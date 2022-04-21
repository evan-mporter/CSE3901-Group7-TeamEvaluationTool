class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  before_action :inst_verify

  # GET /projects or /projects.json
  def index
    @projects = Project.all.sort{|s| s.created_at}
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:success] = "Project was successfully created." 
      redirect_to project_url(@project)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
      if @project.update(project_params)
        flash[:success] = "Project was successfully updated."
        redirect_to project_url(@project)
      else
        render :edit, status: :unprocessable_entity
      end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    Group.all.each { |g| @project.feedback_for(g).destroy_all }
    @project.destroy

    flash[:success] = "Project was successfully destroyed."
    redirect_to projects_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :is_open)
    end

    def inst_verify
      return redirect_to root_path unless inst_logged_in?
    end
end
