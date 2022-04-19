class StudentsController < ApplicationController
  

  before_action :set_student, only: %i[ show edit update destroy ]

  def login
    redirect_to students_email_url
  end

  def login_process
    set_student # TODO: Can't you add this to the before action
  end

  def check
    set_student # TODO: Can't you add this to the before action
    if @student.authenticate(params[:password])
      log_in_student(@student)
      #TODO
      redirect_to student_url(id: @student)
    else 
      flash.now[:alert] = "Wrong password!"+params[:password]
      render "login_process"
    end
  end

  def logout
    log_out
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
      #TODO a notice that your email is not valid
      respond_to do |format|
        format.html { redirect_to students_email_url, notice: "This email is not registered. Use another one." }
        format.json { head :no_content }
      end
    else
      if @student.signed
          redirect_to url_for(action: "login_process", id: @student)
      else
        #TODO a notice that you are not signed up, please sign up
          log_out
          log_in_student @student
          redirect_to edit_student_url(id: @student)
      end
    end
  end


  # GET /students or /students.json
  def index
    if not is_logged_in?
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
    set_student # TODO: set_student gets called by before_action
    if !is_logged_in?
      redirect_to login_url
      return
    end
    
    if not student_logged_in? @student
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
    if not is_logged_in?
      redirect_to login_url
      return
    end
    if not student_logged_in? @student
      redirect_to login_url
      return
    end
    
    @mode = "editing"
    set_student # TODO: set_student gets called by before_action
    if !@student.signed
      @mode = "signup"
    end
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)
    @student.email = @student.email.downcase
    respond_to do |format|
      if @student.save
        format.html { redirect_to student_url(id: @student, mode: "instructor"), notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to student_url(@student), notice: "All set!" }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    log_out if student_logged_in? @student
  
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
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
