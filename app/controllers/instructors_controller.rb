class InstructorsController < ApplicationController
  before_action :set_instructor, only: %i[ show edit update destroy login_process check]
  before_action :inst_verify, only: %i[ index show edit ]

  def login
    return redirect_to instructors_email_url
  end

  def login_process
    
  end

  def check
    if @instructor.authenticate(params[:password])
      # TODO: Avoid logging in student & instructor at the same time
      log_in_instructor(@instructor)
      return redirect_to instructor_url(id: @instructor)
    else 
      flash.now[:danger] = "Wrong password!"
      render "login_process"
    end
  end

  def emailchecker
    @instructor_email = params[:email].downcase
    @instructor = Instructor.find_by(email: @instructor_email)
    if !@instructor
        flash.now[:danger] = "This email is not registered. Use another one."
        return redirect_to instructors_email_url
    else
      return redirect_to url_for(action: "login_process", id: @instructor)
    end
  end

  def logout
    log_out!
    return redirect_to login_url
  end

  def email

  end

  def signup
    redirect_to instructors_email_url
  end

  # GET /instructors or /instructors.json
  def index
    # TODO: Did we want students to be able to view the list of instructors? 
    
    @instructors = Instructor.all
    @instructors = @instructors.sort
  end

  # GET /instructors/1 or /instructors/1.json
  def show

  end

  # GET /instructors/new
  def new
    return redirect_to root_path unless Instructor.count.zero? || inst_logged_in?
    @instructor = Instructor.new
  end

  # GET /instructors/1/edit
  def edit
    return redirect_to root_path unless inst_logged_in? @instructor
    @mode = "editing"
  end

  # POST /instructors or /instructors.json
  def create
    @instructor = Instructor.new(instructor_params)

    if @instructor.save
      flash[:success] = "Instructor was successfully created."
      redirect_to instructor_url(@instructor)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /instructors/1 or /instructors/1.json
  def update
    if @instructor.update(instructor_params)
      flash[:success] = "All set!"
      redirect_to instructor_url(@instructor)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /instructors/1 or /instructors/1.json
  def destroy
    log_out! if inst_logged_in? @instructor
    
    @instructor.destroy
    flash[:success] = "Instructor was successfully destroyed."
    redirect_to instructors_url
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

    def inst_verify
      return redirect_to root_path unless inst_logged_in?
    end
end
