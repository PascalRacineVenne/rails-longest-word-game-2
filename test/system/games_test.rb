require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    take_screenshot
    assert_selector "li", count: 10
  end

  test "the word is not in the grid" do
    visit new_url
    fill_in "word", with: "fantastic"
    click_on  "PLAY"
    
    assert_text "Sorry but FANTASTIC cannot be built out of these letters."
  end

  # test "one-letter consonant word" do
  #   visit new_url
  #   fill_in "word", with: "t"
  #   click_on  "PLAY"

  #   assert_text "Sorry but T doesn't seem to be a valid english word..."
  # end
end
