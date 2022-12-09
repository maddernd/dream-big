require "test_helper"

class GoalTest < ActiveSupport::TestCase
  
  test "goal fixture exists for foreign key plans" do
    assert_equal 1, goal(:goal).id
    assert_equal goal(:goal).id, plans(:plan).goal_id
  end
  
  test "goal fixture exists for foreign key reflections" do
    assert_equal 2, goal(:goal).id
    assert_equal goal(:goal).id, reflections(:refleciton).goal_id
  end

  test "goal fixture exists" do
    assert_equal "new goal", goal(:goal_2).description
  end

  test "cant create an empty goal" do
    goal = Goal.new
    assert_not goal.save, "Created empty goal"
  end

  test "can create goal without a section" do
    goal = Goal.new
    description = "gibberish"
    goal_created_at = DateTime.now
    assert_not goal.save, "Created goal without section id"
  end

end

