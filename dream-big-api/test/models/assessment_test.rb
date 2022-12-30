require "test_helper"

class AssessmentTest < ActiveSupport::TestCase
  test "belongs_to association with journey is valid" do
    assert_equal journeys(:journey_1), assessments(:assessment_1).journey
  end

  test "belongs_to association with category is valid" do
    assert_equal categories(:category_1), assessments(:assessment_1).category
  end

  test "valid assessment can be saved with a valid journey and category" do
    assessment = Assessment.new(journey: journeys(:journey_2), category: categories(:category_1))
    assert assessment.save, "assessment not saved"
  end

  test "invalid assessment cannot be saved with an invalid journey" do
    assessment = Assessment.new(journey: nil, category: categories(:category_1))
    assert_not assessment.save, "assessment saved with invalid journey"
  end

  test "invalid assessment cannot be saved with an invalid category" do
    assessment = Assessment.new(journey: journeys(:journey_2), category: nil)
    assert_not assessment.save, "assessment saved with invalid category"
  end

  test "modifying category and saving existing assessment record works" do
    assessment = assessments(:assessment_1)
    assessment.category = categories(:category_2)
    assessment.save
    assert_equal categories(:category_2), assessment.category, "category not modified"
  end

  test "modifying journey and saving existing assessment record works" do
    assessment = assessments(:assessment_1)
    assessment.journey = journeys(:journey_3)
    assessment.save
    assert_equal journeys(:journey_3), assessment.journey, "journey not modified"
  end
end
