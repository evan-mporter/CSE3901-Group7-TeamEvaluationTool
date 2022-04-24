require "test_helper"

class FeedbackItemTest < ActiveSupport::TestCase
  #set up a feedbackItem
  def setup
    user1 = Student.new(id:1, name: "Example User", password: "Defaultpass3901+", email: "user1@example.com")
    user1.save
    user2 = Student.new(id:2, name: "Example User", password: "Defaultpass3901+", email: "user2@example.com")
    user2.save
    project = Project.new(id:1, name: "test1")
    project.save
    @feedback_item = FeedbackItem.new(project_id: 1, author_id: 1, target_id: 2, participation: 3, quality: 4, disagreements: 5, comments: "test")
  end

  #test wether it is valid
  test "should be valid" do
    assert @feedback_item.valid?
  end

  #test the name should be present
  test "participation should be present" do
    @feedback_item.participation = nil
    assert_not @feedback_item.valid?
  end

  #test the quality should be present
  test "quality should be present" do
    @feedback_item.quality = nil
    assert_not @feedback_item.valid?
  end

  #test the disagreements should be present
  test "disagreements should be present" do
    @feedback_item.disagreements = nil
    assert_not @feedback_item.valid?
  end

  #pariticipation should be between 1 and 5
  test "participation should not be too long" do
    @feedback_item.participation = 6
    assert_not @feedback_item.valid?
  end

  #quality should be between 1 and 5
  test "quality should not be too long" do
    @feedback_item.quality = 6
    assert_not @feedback_item.valid?
  end

  #disagreement should be between 1 and 5
  test "disagreements should not be too long" do
    @feedback_item.disagreements = 6
    assert_not @feedback_item.valid?
  end
end
