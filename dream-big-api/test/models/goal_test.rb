require "test_helper"

class GoalTest < ActiveSupport::TestCase
  def setup
    # create section and reflection records
    @section = sections(:section_1)
    @reflection = reflections(:reflection_1)

    # create goal record
    @goal = Goal.create(
      description: 'my goal',
      status: 'in progress',
      section: @section
    )
  end

  test "goal belongs to association with section is valid" do
    assert_equal @section, @goal.section
  end

  test "goal has one association with reflection is valid" do
    @goal.reflection = @reflection
    @goal.save
    assert_equal @reflection, @goal.reflection
  end

  test "goal attribute 'description' can be modified and saved" do
    @goal.description = 'updated goal description'
    @goal.save
    assert_equal 'updated goal description', @goal.description
  end

  test "goal attribute 'status' can be modified and saved" do
    @goal.status = 'completed'
    @goal.save
    assert_equal 'completed', @goal.status
  end

  test "goal cannot be saved without a section" do
    @goal.section = nil
    assert_not @goal.save, "Saved goal without a section"
  end
end
