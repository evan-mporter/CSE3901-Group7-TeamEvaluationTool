class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]
  before_action :inst_verify

  # GET /groups or /groups.json
  def index
    #regular index
    @groups = Group.all
  end

  # GET /groups/1 or /groups/1.json
  def show
    #only for view
  end

  # GET /groups/new
  def new
    #regular new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
    #only for view
  end

  # POST /groups or /groups.json
  def create
    #regular create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = "Group was successfully created." 
      redirect_to group_url(@group)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    #regular update
    if @group.update(group_params)
      flash[:success] = "Group was successfully updated."
      redirect_to group_url(@group)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    #regular destroy
    @group.destroy
    flash[:success] = "Group was successfully destroyed."
    redirect_to groups_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:name, student_ids: [])
    end

    def inst_verify
      return redirect_to root_path unless inst_logged_in?
    end
end
