require "test_helper"

class RecurrentCardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recurrent_card = recurrent_cards(:one)
  end

  test "should get index" do
    get recurrent_cards_url
    assert_response :success
  end

  test "should get new" do
    get new_recurrent_card_url
    assert_response :success
  end

  test "should create recurrent_card" do
    assert_difference("RecurrentCard.count") do
      post recurrent_cards_url, params: { recurrent_card: { board_id: @recurrent_card.board_id, name: @recurrent_card.name } }
    end

    assert_redirected_to recurrent_card_url(RecurrentCard.last)
  end

  test "should show recurrent_card" do
    get recurrent_card_url(@recurrent_card)
    assert_response :success
  end

  test "should get edit" do
    get edit_recurrent_card_url(@recurrent_card)
    assert_response :success
  end

  test "should update recurrent_card" do
    patch recurrent_card_url(@recurrent_card), params: { recurrent_card: { board_id: @recurrent_card.board_id, name: @recurrent_card.name } }
    assert_redirected_to recurrent_card_url(@recurrent_card)
  end

  test "should destroy recurrent_card" do
    assert_difference("RecurrentCard.count", -1) do
      delete recurrent_card_url(@recurrent_card)
    end

    assert_redirected_to recurrent_cards_url
  end
end
