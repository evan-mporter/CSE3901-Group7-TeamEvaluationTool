require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:one)
  end

  test "should get index" do
    get projects_url
    assert_redirected_to "/"
  end

  test "should get new" do
    get new_project_url
    assert_redirected_to "/"
  end

  #Can not be tested when session check is needed
  #test "should create project" do
    #assert_difference('Project.count') do
      #post projects_url, params: { project: { is_open: @project.is_open, name: @project.name } }
    #end

    #assert_redirected_to project_url(Project.last)
  #end

  test "should show project" do
    get project_url(@project)
    assert_redirected_to "/"
  end

  test "should get edit" do
    get edit_project_url(@project)
    assert_redirected_to "/"
  end

  test "should update project" do
    patch project_url(@project), params: { project: { is_open: @project.is_open, name: @project.name } }
    assert_redirected_to "/"
  end

  #Can not be tested when session check needed
  #test "should destroy project" do
    #assert_difference('Project.count', -1) do
      #delete project_url(@project)
    #end

    #assert_redirected_to projects_url
  #end
end
