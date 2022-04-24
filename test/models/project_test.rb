require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  #set up project
  def setup
    @project = Project.new(id:1, name: "test1")
  end

  #test wether it is valid
  test "should be valid" do
    assert @project.valid?
  end

  #test the name should not be too long with 50 max
  test "name should not be too long" do
    @project.name = "a" * 51
    assert_not @project.valid?
  end


end
