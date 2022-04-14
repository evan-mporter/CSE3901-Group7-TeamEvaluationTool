class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  def login
    if @student == nil
      redirect_to students_email_url
    end
  end

  def check
  end

  def logout
  end

  def email
  end

  def signup
  end

  def emailchecker
    @student_email = params[:email]
    @student = Student.find_by(email: @student_email)
    if !@student
      #TODO a notice that your email is not valid
      respond_to do |format|
        format.html { redirect_to students_email_url, notice: "This email is not registered. Use another one." }
        format.json { head :no_content }
      end
    else
      if @student.signed
        respond_to do |format|
          format.html { redirect_to students_login_url(:student => @student), notice: "Please sign in with your password.", mode: "signup"}
          format.json { head :no_content }
        end
      else
        #TODO a notice that you are not signed up, please sign up
          redirect_to edit_student_url(@student), notice: "Since this account is not signed up, please sign up.", mode: 'signup' 
      end
    end
  end


  # GET /students or /students.json
  def index
    #if !helpers.is_instr_logged_in?
    #  redirect_to student_url(helpers.current_student)
    #end
    @students = Student.all
    @students = @students.sort
  end

  # GET /students/1 or /students/1.json
  def show
    if !helpers.is_logged_in?
      redirect_to students_email_url
    end
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
    #if !helpers.is_logged_in?
    #  redirect_to students_email_url
    #end
  end

  def instructor_new
    if !helpers.is_instr_logged_in?
      redirect_to students_email_url
    else
      @student = Student.new
    end
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)
    respond_to do |format|
      if @student.save
        format.html { redirect_to student_url(@student), notice: "Student was successfully created." }
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
        format.html { redirect_to student_url(@student), notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
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
      params.require(:student).permit(:name, :password, :email)
    end
end
