require "application_system_test_case"

class RecurrentCardsTest < ApplicationSystemTestCase
  setup do
    @recurrent_card = recurrent_cards(:one)
  end

  test "visiting the index" do
    visit recurrent_cards_url
    assert_selector "h1", text: "Recurrent cards"
  end

  test "should create recurrent card" do
    visit recurrent_cards_url
    click_on "New recurrent card"

    fill_in "Board", with: @recurrent_card.board_id
    fill_in "Name", with: @recurrent_card.name
    click_on "Create Recurrent card"

    assert_text "Recurrent card was successfully created"
    click_on "Back"
  end

  test "should update Recurrent card" do
    visit recurrent_card_url(@recurrent_card)
    click_on "Edit this recurrent card", match: :first

    fill_in "Board", with: @recurrent_card.board_id
    fill_in "Name", with: @recurrent_card.name
    click_on "Update Recurrent card"

    assert_text "Recurrent card was successfully updated"
    click_on "Back"
  end

  test "should destroy Recurrent card" do
    visit recurrent_card_url(@recurrent_card)
    click_on "Destroy this recurrent card", match: :first

    assert_text "Recurrent card was successfully destroyed"
  end
end
