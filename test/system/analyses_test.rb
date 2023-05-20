require "application_system_test_case"

class AnalysesTest < ApplicationSystemTestCase
  setup do
    @analysis = analyses(:one)
  end

  test "visiting the index" do
    visit analyses_url
    assert_selector "h1", text: "Analyses"
  end

  test "should create analysis" do
    visit analyses_url
    click_on "New analysis"

    fill_in "Board", with: @analysis.board_id
    fill_in "End date", with: @analysis.end_date
    fill_in "Name", with: @analysis.name
    fill_in "Pos planning", with: @analysis.pos_planning
    fill_in "Pre planning", with: @analysis.pre_planning
    fill_in "Start date", with: @analysis.start_date
    fill_in "Status", with: @analysis.status
    click_on "Create Analysis"

    assert_text "Analysis was successfully created"
    click_on "Back"
  end

  test "should update Analysis" do
    visit analysis_url(@analysis)
    click_on "Edit this analysis", match: :first

    fill_in "Board", with: @analysis.board_id
    fill_in "End date", with: @analysis.end_date
    fill_in "Name", with: @analysis.name
    fill_in "Pos planning", with: @analysis.pos_planning
    fill_in "Pre planning", with: @analysis.pre_planning
    fill_in "Start date", with: @analysis.start_date
    fill_in "Status", with: @analysis.status
    click_on "Update Analysis"

    assert_text "Analysis was successfully updated"
    click_on "Back"
  end

  test "should destroy Analysis" do
    visit analysis_url(@analysis)
    click_on "Destroy this analysis", match: :first

    assert_text "Analysis was successfully destroyed"
  end
end
