require "test_helper"

class InstructorsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @instructor = instructors(:one)
    @grader     = instructors(:two)
  end

  #Testing before instrutor login, intended to check security.

  test "should get login" do
    get login_url
    assert_response :success
  end

  test "should get instructor login" do
    get instructors_login_url
    assert_redirected_to instructors_email_url
  end

  test "should redirect get index" do
    get instructors_url
    assert_redirected_to login_url
  end

  test "should redirect get edit" do
    get edit_instructor_url(@instructor)
    assert_redirected_to instructors_email_url
  end

  #Testing functionality before instructor log in

  test "should get new" do
    get new_instructor_url
    assert_response :success
  end

  #test "should get index" do
    #get instructors_url
    #assert_response :success
  #end

  #test "should create instructor" do
    #assert_difference('Instructor.count') do
      #post instructors_url, params: { instructor: { email: @instructor.email, name: @instructor.name, password: @instructor.password } }
    #end

    #assert_redirected_to instructor_url(Instructor.last)
  #end

  #This should redirect, fix error located in line 61 instructor controller, add condition to check if generally logged in and redirect.
  test "should show instructor" do
    get instructor_url(@instructor)
    assert_response :success
  end

  #test "should get edit" do
    #get edit_instructor_url(@instructor)
    #assert_response :success
  #end

  #test "should update instructor" do
    #patch instructor_url(@instructor), params: { instructor: { email: @instructor.email, name: @instructor.name, password: @instructor.password } }
    #assert_redirected_to instructor_url(@instructor)
  #end

  #test "should destroy instructor" do
    #assert_difference('Instructor.count', -1) do
     # delete instructor_url(@instructor)
    #end

    #assert_redirected_to instructors_url
  #end
end
