require 'test_helper'

class QuestionAnswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question_answer = question_answers(:one)
  end

  test "should get index" do
    get question_answers_url
    assert_response :success
  end

  test "should get new" do
    get new_question_answer_url
    assert_response :success
  end

  test "should create question_answer" do
    assert_difference('QuestionAnswer.count') do
      post question_answers_url, params: { question_answer: { answer: @question_answer.answer, question: @question_answer.question } }
    end

    assert_redirected_to question_answer_url(QuestionAnswer.last)
  end

  test "should show question_answer" do
    get question_answer_url(@question_answer)
    assert_response :success
  end

  test "should get edit" do
    get edit_question_answer_url(@question_answer)
    assert_response :success
  end

  test "should update question_answer" do
    patch question_answer_url(@question_answer), params: { question_answer: { answer: @question_answer.answer, question: @question_answer.question } }
    assert_redirected_to question_answer_url(@question_answer)
  end

  test "should destroy question_answer" do
    assert_difference('QuestionAnswer.count', -1) do
      delete question_answer_url(@question_answer)
    end

    assert_redirected_to question_answers_url
  end
end
