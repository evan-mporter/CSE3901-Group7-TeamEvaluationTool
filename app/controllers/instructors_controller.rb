class InstructorsController < ApplicationController
  before_action :set_instructor, only: %i[ show edit update destroy ]

  def login
    redirect_to instructors_email_url
  end

  def login_process
    set_instructor # TODO: cant you put this into before_action?
  end

  def check
    set_instructor # TODO: cant you put this into before_action?
    if @instructor.authenticate(params[:password])
      # TODO: Avoid logging in student & instructor at the same time
      log_in_instructor(@instructor)
      redirect_to instructor_url(id: @instructor)
    else 
      flash.now[:alert] = "Wrong password!"+params[:password]
      render "login_process"
    end
  end

  def emailchecker
    @instructor_email = params[:email].downcase
    @instructor = Instructor.find_by(email: @instructor_email)
    if !@instructor
      respond_to do |format|
        format.html { redirect_to instructors_email_url, notice: "This email is not registered. Use another one." }
        format.json { head :no_content }
      end
    else
      redirect_to url_for(action: "login_process", id: @instructor)
    end
  end

  def logout
    log_out!
    redirect_to login_url
  end

  def email

  end

  def signup
    redirect_to instructors_email_url
  end

  # GET /instructors or /instructors.json
  def index
    if not logged_in?
      redirect_to login_url
      return
    end
    
    # TODO: Did we want students to be able to view the list of instructors? 
    
    @instructors = Instructor.all
    @instructors = @instructors.sort
  end

  # GET /instructors/1 or /instructors/1.json
  def show
    set_instructor # TODO: Doesn't the before_action handle this?
    if not inst_logged_in? @instructor
      redirect_to login_url
    end
    
  end

  # GET /instructors/new
  def new
    @instructor = Instructor.new
  end

  # GET /instructors/1/edit
  def edit
    @mode = "editing"
    set_instructor # TODO: Doesn't the before_action handle this?
    if not logged_in? # TODO: We don't want a student to be able to edit an instructor account
      redirect_to instructors_email_url
     end
  end

  # POST /instructors or /instructors.json
  def create
    @instructor = Instructor.new(instructor_params)

    respond_to do |format|
      if @instructor.save
        format.html { redirect_to instructor_url(@instructor), notice: "Instructor was successfully created." }
        format.json { render :show, status: :created, location: @instructor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @instructor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instructors/1 or /instructors/1.json
  def update
    respond_to do |format|
      if @instructor.update(instructor_params)
        format.html { redirect_to instructor_url(@instructor), notice: "All set!" }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @instructor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instructors/1 or /instructors/1.json
  def destroy
    log_out! if inst_logged_in? @instructor
    
    @instructor.destroy
    respond_to do |format|
      format.html { redirect_to instructors_url, notice: "Instructor was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instructor
      @instructor = Instructor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def instructor_params
      params.require(:instructor).permit(:name, :email, :password)
    end
end
