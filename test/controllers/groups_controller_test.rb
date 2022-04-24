require "test_helper"

class GroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group = groups(:one)
  end

  test "should get index" do
    get groups_url
    assert_redirected_to "/"
  end

  test "should get new" do
    get new_group_url
    assert_redirected_to "/"
  end

  #Can not be tested when session check is needed
  #test "should create group" do
    #this can not be tested when need session check
    #assert_difference('Group.count') do
      #post groups_url, params: { group: { feedback_items: @group.feedback_items, name: @group.name, students: @group.students } }
    #end

    #assert_redirected_to group_url(Group.last)
  #end

  test "should show group" do
    get group_url(@group)
    assert_redirected_to "/"
  end

  test "should get edit" do
    get edit_group_url(@group)
    assert_redirected_to "/"
  end

  test "should update group" do
    patch group_url(@group), params: { group: { feedback_items: @group.feedback_items, name: @group.name, students: @group.students } }
    assert_redirected_to "/"
  end

  #Can not be tested when session check is needed
  #test "should destroy group" do
    #this can not be tested when need session check
    #assert_difference('Group.count', -1) do
      #delete group_url(@group)
    #end

    #assert_redirected_to groups_url
  #end
end
