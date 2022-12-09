require "test_helper"

class AnswerTest < ActiveSupport::TestCase

  test "category question fixture exists for foreign key" do
    assert_equal 1, category_questions(:category_question).id
    assert_equal category_questions(:category_question).id, answers(:answer).category_question_id
  end

  test "assessment fixture exists for foreign key" do
    assert_equal 1, assessments(:assessment).id
    assert_equal assessments(:assessment).id, answers(:answer).assessment_id
  end

  test "should save when category_question_id(FK) exists in answers table" do
    answer = Answer.new
    answer.category_question_id = category_questions(:category_question).id
    assert answer.save, "answer not saved"
  end

  test "should error when category_question_id(FK) does not exist in answers table" do
    answer = Answer.new
    answer.category_question_id = 123456789426
    assert_raises(ActiveRecord::InvalidForeignKey) do answer.save
    end
  end

  test "should save when assessment_id(FK) exists in answers table" do
    answer = Answer.new
    answer.assessment_id = assessments(:assessment).id
    assert answer.save, "answer not saved"
    end

  test "should error when assessment_id(FK) does not exist in answers table" do
    answer = Answer.new
    answer.assessment_id = 123456789426
    assert_raises(ActiveRecord::InvalidForeignKey) do answer.save
    end
  end
  
  test "all fields should save when both foreign keys exist" do
    answer = Answer.new
    answer.category_question_id = category_questions(:category_question).id
    answer.assessment_id = assessments(:assessment).id
    answer.answer = "The answer is 7"
    assert answer.save, "answer not saved"
  end

  test "should modify category_question_id and save existing answer record " do
    answer = answers(:answer)
    answer.category_question_id = category_questions(:category_question_2).id
    answer.save
    assert_equal( category_questions(:category_question_2).id, answer.category_question_id, "category_question_id not modified")
  end 

  test "should modify answer field and save existing record " do
    answer = answers(:answer)
    answer.answer = "Mississippi"
    answer.save
    assert_equal( "Mississippi", answer.answer, "answer field not modified")
  end 

  test "should modify assessment id and save existing answer record " do
    answer = answers(:answer)
    answer.assessment_id = assessments(:assessment_2).id
    answer.save
    assert_equal( assessments(:assessment_2).id, answer.assessment_id, "assessment_id not modified")
  end 

end
