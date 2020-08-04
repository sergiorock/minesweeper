require "application_system_test_case"

class CellsTest < ApplicationSystemTestCase
  setup do
    @cell = cells(:one)
  end

  test "visiting the index" do
    visit cells_url
    assert_selector "h1", text: "Cells"
  end

  test "creating a Cell" do
    visit cells_url
    click_on "New Cell"

    fill_in "Game", with: @cell.game_id
    check "Is revealed" if @cell.is_revealed
    fill_in "Valor", with: @cell.valor
    fill_in "X", with: @cell.x
    fill_in "Y", with: @cell.y
    click_on "Create Cell"

    assert_text "Cell was successfully created"
    click_on "Back"
  end

  test "updating a Cell" do
    visit cells_url
    click_on "Edit", match: :first

    fill_in "Game", with: @cell.game_id
    check "Is revealed" if @cell.is_revealed
    fill_in "Valor", with: @cell.valor
    fill_in "X", with: @cell.x
    fill_in "Y", with: @cell.y
    click_on "Update Cell"

    assert_text "Cell was successfully updated"
    click_on "Back"
  end

  test "destroying a Cell" do
    visit cells_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cell was successfully destroyed"
  end
end
