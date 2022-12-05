require "test_helper"

class PlanTest < ActiveSupport::TestCase
  test "section fixture exists for foreign key" do
    assert_equal 1, sections(:section).id
    assert_equal sections(:section).id, plans(:plan).section_id
  end

  test "goal fixture exists for foreign key" do
    assert_equal 2, goals(:goal).id
    assert_equal goals(:goal).id, plans(:plan).goal_id
  end

  test "should save plan when goal_id(FK) exists in goals table" do
    plan = Plan.new
    plan.goal_id = goals(:goal).id
    assert plan.save, "plan not saved"
  end

  test "should error when goal_id(FK) does not exist in goals table" do
    plan = Plan.new
    plan.goal_id = 123456789426
    assert_raises(ActiveRecord::InvalidForeignKey) do plan.save
    end
  end

  test "should save plan when section_id(FK) exists in section table" do
    plan = Plan.new
    plan.section_id = sections(:section).id
    assert plan.save, "plan not saved"
  end

  test "should error when section_id(FK) does not exist in sections table" do
    plan = Plan.new
    plan.section_id = 123456789426
    assert_raises(ActiveRecord::InvalidForeignKey) do plan.save
    end
  end
  
  test "all fields should save when goal_id and section_id exist" do
    plan = Plan.new
    plan.goal_id = goals(:goal).id
    plan.section_id = sections(:section).id
    plan.plan_text = "New plan"
    assert plan.save, "plan not saved"
  end

  test "should modify existing plan text " do
  plan = plans(:plan)
  plan.plan_text = "new plan text"
  plan.save
  assert_equal( "new plan text", plan.plan_text, "plan_text has not been modified")
  end

  test "should modify existing section id " do
    plan = plans(:plan)
    plan.section_id = 2
    plan.save
    assert_equal( 2, plan.section_id, "section_id not been modified")
    end

    test "should modify existing goal id " do
      plan = plans(:plan)
      plan.goal_id = 3
      plan.save
      assert_equal( 3, plan.goal_id, "goal_id not been modified")
      end  

  end

