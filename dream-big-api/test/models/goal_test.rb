require "test_helper"

class GoalTest < ActiveSupport::TestCase
  test "cant create an empty goal" do
    goal = Goal.new
    assert_not goal.save, "Created empty goal"
  end

  test "can create goal without a section" do
    goal = Goal.new
    goal_text = "gibberish"
    goal_created_at = DateTime.now
    assert_not goal.save, "Created goal without section id"
  end

  test "goal fixture exists" do
    assert_equal "mygoal", goal(:admin).goal_text
  end
end
