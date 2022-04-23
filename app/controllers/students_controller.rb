class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy login_process check ]

  def login
    #redirect to email to check email
    return redirect_to students_email_url
  end

  def login_process
    #only for view
  end

  def check
    #the login check process for student
    if @student.authenticate(params[:password])
      log_in_student(@student)
      return redirect_to student_url(id: @student)
    else 
      flash.now[:danger] = "Wrong password!"
      render "login_process"
    end
  end

  def logout
    #logout the current student
    log_out!
    return redirect_to login_url
  end

  def email
    #only for view
  end

  def signup
    #redirect to email to check email
    return redirect_to students_email_url
  end

  def emailchecker
    #check whether the email is registered by instructor.
    @student_email = params[:email].downcase
    @student = Student.find_by(email: @student_email)
    if !@student
        flash[:danger] = "This email is not registered. Use another one."
        return redirect_to students_email_url
    else
      #if yes, then redirect to signup or login based on wether it is signed
      if @student.signed
          return redirect_to url_for(action: "login_process", id: @student)
      else
          log_in_student @student
          return redirect_to edit_student_url(id: @student)
      end
    end
  end

  # GET /students or /students.json
  def index
    #if not login then login
    if not logged_in?
      redirect_to login_url
      return
    end
    #if not instructor login then redirect to student file
    if student_logged_in?
      redirect_to student_url(current_student)
      return
    end
    #Alphabetic sort
    @students = Student.all
    @students = @students.sort
  end

  # GET /students/1 or /students/1.json
  def show
    #check the ID information to allow show
    if not inst_logged_in? and not student_logged_in? @student
      redirect_to login_url
      return
    end
  end

  # GET /students/new
  def new
    #restrict this function only to instructor
    if not inst_logged_in?
      redirect_to instructors_email_url
      return
    end
    #create student
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
    #redirect to edit view depends on who is logging in and whether the student is signed up.
    if not inst_logged_in? and not student_logged_in? @student
      redirect_to login_url
      return
    end
    @mode = "editing"
    if !@student.signed
      @mode = "signup"
    end
  end

  # POST /students or /students.json
  def create
    #create a student and record the email as lowercase
    @student = Student.new(student_params)
    @student.email = @student.email.downcase
    if @student.save
      flash[:success] = "Student was successfully created."
      return redirect_to student_url(id: @student)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    #regular update
    if @student.update(student_params)
      flash[:success] = "All set!"
      return redirect_to student_url(@student)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    #before destroy the student, log him out
    log_out! if student_logged_in? @student
    @student.destroy
    flash[:success] = "Student was successfully destroyed."
    return redirect_to students_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:signed, :name, :password, :email)
    end
end
