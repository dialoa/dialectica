require "application_system_test_case"

class QuestionAnswersTest < ApplicationSystemTestCase
  setup do
    @question_answer = question_answers(:one)
  end

  test "visiting the index" do
    visit question_answers_url
    assert_selector "h1", text: "Question Answers"
  end

  test "creating a Question answer" do
    visit question_answers_url
    click_on "New Question Answer"

    fill_in "Answer", with: @question_answer.answer
    fill_in "Question", with: @question_answer.question
    click_on "Create Question answer"

    assert_text "Question answer was successfully created"
    click_on "Back"
  end

  test "updating a Question answer" do
    visit question_answers_url
    click_on "Edit", match: :first

    fill_in "Answer", with: @question_answer.answer
    fill_in "Question", with: @question_answer.question
    click_on "Update Question answer"

    assert_text "Question answer was successfully updated"
    click_on "Back"
  end

  test "destroying a Question answer" do
    visit question_answers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Question answer was successfully destroyed"
  end
end
