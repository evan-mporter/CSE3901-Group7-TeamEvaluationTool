class InstructorsController < ApplicationController
  before_action :set_instructor, only: %i[ show edit update destroy login_process check]
  before_action :inst_verify, only: %i[ index show edit ]

  def login
    #redirect to email to check email
    return redirect_to instructors_email_url
  end

  def login_process
    #view only
  end

  def check
    if @instructor.authenticate(params[:password])
      #Avoid logging in student & instructor at the same time
      log_in_instructor(@instructor)
      return redirect_to instructor_url(id: @instructor)
    else
      #mention for wrong password
      flash.now[:danger] = "Wrong password!"
      render "login_process"
    end
  end

  def emailchecker
    #check if the email in registered
    @instructor_email = params[:email].downcase
    @instructor = Instructor.find_by(email: @instructor_email)
    #redirect to signup or login based on wether the instructor is signed up
    if !@instructor
        flash.now[:danger] = "This email is not registered. Use another one."
        return redirect_to instructors_email_url
    else
      return redirect_to url_for(action: "login_process", id: @instructor)
    end
  end

  def logout
    #log out the session
    log_out!
    return redirect_to login_url
  end

  def email
    #only for view
  end

  def signup
    #redirect to email to check email
    redirect_to instructors_email_url
  end

  # GET /instructors or /instructors.json
  def index
    #for index view
    @instructors = Instructor.all
    @instructors = @instructors.sort
  end

  # GET /instructors/1 or /instructors/1.json
  def show
    #only for view
  end

  # GET /instructors/new
  def new
    #allow for instructor register based on whether there is any instructor exist.
    return redirect_to root_path unless Instructor.count.zero? || inst_logged_in?
    @mode = "signup"
    @instructor = Instructor.new
  end

  # GET /instructors/1/edit
  def edit
    #allow for editing
    return redirect_to root_path unless inst_logged_in? @instructor
    @mode = "editing"
  end

  # POST /instructors or /instructors.json
  def create
    #TODO:comments
    @instructor = Instructor.new(instructor_params)
    if @instructor.save
      flash[:success] = "Instructor was successfully created."
      if Instructor.count == 1
        log_in_instructor @instructor
        return redirect_to root_path
      else 
        return redirect_to instructor_url(@instructor)
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /instructors/1 or /instructors/1.json
  def update
    #TODO:comments
    if @instructor.update(instructor_params)
      flash[:success] = "All set!"
      redirect_to instructor_url(@instructor)
    else
      @mode = "editing"
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /instructors/1 or /instructors/1.json
  def destroy
    #first logout if not
    log_out! if inst_logged_in? @instructor
    #destroy the instructor from database
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
