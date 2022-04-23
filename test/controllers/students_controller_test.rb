require "test_helper"

class StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student = students(:one)
  end

  test "should get index" do
    get students_url
    assert_response :success
  end

  test "should get new" do
    get new_student_url
    assert_redirected_to "/instructors/email"
  end

  test "should show student" do
    get student_url(@student)
    assert_redirected_to "/login"
  end

  test "should get edit" do
    get edit_student_url(@student)
    assert_redirected_to "/login"
  end

  test "should destroy student" do
    assert_difference('Student.count', -1) do
      delete student_url(@student)
    end
    assert_redirected_to students_url
  end

  test "should get email" do
    get students_email_url
    assert_response:success
  end

end
