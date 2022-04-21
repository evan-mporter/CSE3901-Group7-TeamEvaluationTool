class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy login_process check ]

  def login
    redirect_to students_email_url
  end

  def login_process
  end

  def check
    if @student.authenticate(params[:password])
      log_in_student(@student)
      #TODO
      redirect_to student_url(id: @student)
    else 
      flash.now[:danger] = "Wrong password!"
      render "login_process"
    end
  end

  def logout
    log_out!
    redirect_to login_url
  end

  def email
  end

  def signup
    redirect_to students_email_url
  end

  def emailchecker
    @student_email = params[:email].downcase
    @student = Student.find_by(email: @student_email)
    if !@student
        flash[:danger] = "This email is not registered. Use another one."
        redirect_to students_email_url
    else
      if @student.signed
          redirect_to url_for(action: "login_process", id: @student)
      else
          log_in_student @student
          redirect_to edit_student_url(id: @student)
      end
    end
  end


  # GET /students or /students.json
  def index
    if not logged_in?
      redirect_to login_url
      return
    end
    
    if student_logged_in?
      redirect_to student_url(current_student)
      return
    end
    
    @students = Student.all
    @students = @students.sort
  end

  # GET /students/1 or /students/1.json
  def show
    if not inst_logged_in? and not student_logged_in? @student
      redirect_to login_url
      return
    end
    
    #TODO
  end

  # GET /students/new
  def new
    if not inst_logged_in?
      redirect_to instructors_email_url
      return
    end
    
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
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
    @student = Student.new(student_params)
    @student.email = @student.email.downcase
    if @student.save
      flash[:success] = "Student was successfully created."
      redirect_to student_url(id: @student)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    if @student.update(student_params)
      flash[:success] = "All set!"
      redirect_to student_url(@student)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    log_out! if student_logged_in? @student
  
    @student.destroy
    flash[:success] = "Student was successfully destroyed."
    redirect_to students_url
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
