require "test_helper"

class PlanTest < ActiveSupport::TestCase
  test "plan belongs to association with goal is valid" do
    plan = plans(:plan_1)
    goal = goals(:goal_1)
    assert_equal goal, plan.goal
  end

  test "plan belongs to association with section is valid" do
    plan = plans(:plan_1)
    section = sections(:section_1)
    assert_equal section, plan.section
  end

  test "creating a plan with a valid goal_id and section_id is successful" do
    plan = Plan.new(plan_text: "New plan", goal_id: goals(:goal_1).id, section_id: sections(:section_1).id)
    assert plan.save, "plan was not saved"
  end

  test "creating a plan with a non-existent goal_id results in an error" do
    plan = Plan.new(plan_text: "New plan", goal_id: 123456789426, section_id: sections(:section_1).id)
    assert_not plan.save, "Saved plan without a valid goal"
  end

  test "creating a plan with a non-existent section_id results in an error" do
    plan = Plan.new(plan_text: "New plan", goal_id: goals(:goal_1).id, section_id: 123456789426)
    assert_not plan.save, "Saved plan without a valid section"
  end

  test "updating the plan_text field of an existing plan works" do
    plan = plans(:plan_1)
    plan.plan_text = "new plan text"
    plan.save
    assert_equal "new plan text", plan.plan_text, "plan_text was not updated"
  end

  test "updating the section_id field of an existing plan works" do
    plan = plans(:plan_1)
    plan.section_id = sections(:section_2).id
    plan.save
    assert_equal sections(:section_2).id, plan.section_id, "section_id was not updated"
  end

  test "updating the goal_id field of an existing plan works" do
    plan = plans(:plan_1)
    plan.goal_id = goals(:goal_2).id
    plan.save
    assert_equal goals(:goal_2).id, plan.goal_id, "goal_id was not updated"
  end
end
