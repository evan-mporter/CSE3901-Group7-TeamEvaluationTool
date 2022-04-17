require "application_system_test_case"

class FeedbackItemsTest < ApplicationSystemTestCase
  setup do
    @feedback_item = feedback_items(:one)
  end

  test "visiting the index" do
    visit feedback_items_url
    assert_selector "h1", text: "Feedback Items"
  end

  test "creating a Feedback item" do
    visit feedback_items_url
    click_on "New Feedback Item"

    fill_in "Author", with: @feedback_item.author_id
    fill_in "Comments", with: @feedback_item.comments
    fill_in "Disagreements", with: @feedback_item.disagreements
    fill_in "Participation", with: @feedback_item.participation
    fill_in "Project", with: @feedback_item.project_id
    fill_in "Quality", with: @feedback_item.quality
    fill_in "Target", with: @feedback_item.target_id
    click_on "Create Feedback item"

    assert_text "Feedback item was successfully created"
    click_on "Back"
  end

  test "updating a Feedback item" do
    visit feedback_items_url
    click_on "Edit", match: :first

    fill_in "Author", with: @feedback_item.author_id
    fill_in "Comments", with: @feedback_item.comments
    fill_in "Disagreements", with: @feedback_item.disagreements
    fill_in "Participation", with: @feedback_item.participation
    fill_in "Project", with: @feedback_item.project_id
    fill_in "Quality", with: @feedback_item.quality
    fill_in "Target", with: @feedback_item.target_id
    click_on "Update Feedback item"

    assert_text "Feedback item was successfully updated"
    click_on "Back"
  end

  test "destroying a Feedback item" do
    visit feedback_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Feedback item was successfully destroyed"
  end
end
