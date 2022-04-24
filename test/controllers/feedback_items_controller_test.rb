require "test_helper"

class FeedbackItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @feedback_item = feedback_items(:one)
  end

  #Can not be tested when session check is needed
  #test "should create feedback_item" do
    #assert_difference('FeedbackItem.count') do
      #post feedback_items_url, params: { feedback_item: { author_id: @feedback_item.author_id, comments: @feedback_item.comments, disagreements: @feedback_item.disagreements, participation: @feedback_item.participation, project_id: @feedback_item.project_id, quality: @feedback_item.quality, target_id: @feedback_item.target_id } }
    #end

    #assert_redirected_to feedback_item_url(FeedbackItem.last)
  #end

  test "should show feedback_item" do
    get feedback_item_url(@feedback_item)
    assert_redirected_to "/login"
  end

end
