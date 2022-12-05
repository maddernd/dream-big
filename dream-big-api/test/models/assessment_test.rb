require "test_helper"

class AssessmentTest < ActiveSupport::TestCase
#journey_id, category_id
  test "journeys fixture exists for foreign key" do
    assert_equal 135138681, journeys(:journey_2).id
    assert_equal journeys(:journey_2).id, assessments(:assessment).journey_id
  end

  test "categories fixture exists for foreign key" do
    assert_equal 1, categories(:category).id
    assert_equal categories(:category).id, assessments(:assessment).category_id
  end

  test "should save when journey_id(FK) exists in assessments table" do
    assessment = Assessment.new
    assessment.journey_id = journeys(:journey_2).id
    assert assessment.save, "assessment not saved"
  end

  test "should error when journey_id(FK) does not exist in assessments table" do
    assessment = Assessment.new
    assessment.journey_id = 123456789426
    assert_raises(ActiveRecord::InvalidForeignKey) do assessment.save
    end
  end

  test "should save when category_id(FK) exists in assessments table" do
    assessment = Assessment.new
    assessment.category_id = categories(:category).id
    assert assessment.save, "assessment not saved"
  end

  test "should error when category_id(FK) does not exist in assessments table" do
    assessment = Assessment.new
    assessment.category_id = 123456789426
    assert_raises(ActiveRecord::InvalidForeignKey) do assessment.save
    end
  end
  
  test "all fields should save when journey_id and category_id exist" do
    assessment = Assessment.new
    assessment.category_id = categories(:category).id
    assessment.journey_id = journeys(:journey_2).id
    assert assessment.save, "assessment not saved"
  end

    test "should modify category_id field and save existing assessment record " do
    assessment = assessments(:assessment)
    assessment.category_id = categories(:category_2).id
    assessment.save
    assert_equal( categories(:category_2).id, assessment.category_id, "category_id not modified")
    end 

    test "should modify journey_id field and save existing assessment record " do
      assessment = assessments(:assessment)
      assessment.journey_id = journeys(:journey_3).id
      assessment.save
      assert_equal( journeys(:journey_3).id, assessment.journey_id, "journey_id not modified")
      end 

end
