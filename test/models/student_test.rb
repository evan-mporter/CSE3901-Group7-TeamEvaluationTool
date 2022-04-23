require "test_helper"

class StudentTest < ActiveSupport::TestCase
  #set up a student
  def setup
    @student = Student.new(name: "Example User", password: "Defaultpass3901+", email: "user@example.com")
  end

  #test wether it is valid
  test "should be valid" do
    assert @student.valid?
  end

  #test the name should be present
  test "name should be present" do
    @student.name = ""
    assert_not @student.valid?
  end

  #test the password should be present
  test "password should be present" do
    @student.password = nil
    assert_not @student.valid?
  end

  #test the email should be present
  test "email should be present" do
    @student.email = ""
    assert_not @student.valid?
  end

  #test the name should not be too long with 50 max
  test "name should not be too long" do
    @student.name = "a" * 51
    assert_not @student.valid?
  end

  #test the email should not be too long with 255 max
  test "email should not be too long" do
    @student.name = "a" * 256 + "@osu.edu"
    assert_not @student.valid?
  end

  #test the password should not be too short with 8 min
  test "password shoud not be too short" do
    @student.password = "Abcd1+"
    assert_not @student.valid?
  end

  #test the email should be in good format described in the model
  test "email should be in good format" do
    @student.email = "user@"
    assert_not @student.valid?
  end

  #test the password should be in good format described in the model
  test "password should be in good format" do
    @student.password = "ABCDEFGH"
    assert_not @student.valid?
  end

end
