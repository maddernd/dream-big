require "test_helper"

class JourneyTest < ActiveSupport::TestCase
  test "cant create a journey without a student" do
    journey = Journey.new
    assert_not journey.save, "Saved journey without a student"
  end

  test "can save a journey with a student" do
    journey = Journey.new
    journey.student_id = students(:admin).id
    assert journey.save, "Couldn't Save journey with a student"
  end

  test "journey fixture exists" do
    assert_equal students(:admin).id, journeys(:admin_journey).student_id
  end
end
