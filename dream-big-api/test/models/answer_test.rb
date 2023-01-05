require "test_helper"

class AnswerTest < ActiveSupport::TestCase
  test "belongs_to association with category_question is valid" do
    assert_equal category_questions(:category_question_1), answers(:answer_1).category_question
  end

  test "belongs_to association with assessment is valid" do
    assert_equal assessments(:assessment_1), answers(:answer_1).assessment
  end

  test "valid answer can be saved with a valid category_question and assessment" do
    answer = Answer.new(answer: "This is my answer", category_question: category_questions(:category_question_1), assessment: assessments(:assessment_1))
    assert answer.save, "answer not saved"
  end

  test "invalid answer cannot be saved with an invalid category_question" do
    answer = Answer.new(answer: "This is my answer", category_question: nil, assessment: assessments(:assessment_1))
    assert_not answer.save, "answer saved with invalid category_question"
  end

  test "invalid answer cannot be saved with an invalid assessment" do
    answer = Answer.new(answer: "This is my answer", category_question: category_questions(:category_question_1), assessment: nil)
    assert_not answer.save, "answer saved with invalid assessment"
  end

  test "modifying category_question and saving existing answer record works" do
    answer = answers(:answer_1)
    answer.category_question = category_questions(:category_question_2)
    answer.save
    assert_equal category_questions(:category_question_2), answer.category_question, "category_question not modified"
  end

  test "modifying assessment and saving existing answer record works" do
    answer = answers(:answer_1)
    answer.assessment = assessments(:assessment_2)
    answer.save
    assert_equal assessments(:assessment_2), answer.assessment, "assessment not modified"
  end
end
