require "test_helper"

class ReflectionTest < ActiveSupport::TestCase
  def setup
    # create section and reflection records
    @section = sections(:section_1)
    @goal = goals(:goal_1)
 

    @reflection = Reflection.create(
      reflection_text: 'my text',
      section: @section,
      goal: @goal
    )
  end

  test "reflection belongs to association with section is valid" do
    assert_equal @section, @reflection.section
  end

  test "reflection belongs to association with goal is valid" do
    assert_equal @goal, @reflection.goal
  end

  test "reflection attribute 'reflection_text' can be modified and saved" do
    @reflection.reflection_text = 'updated reflection text'
    @reflection.save
    assert_equal 'updated reflection text', @reflection.reflection_text
  end

  test "reflection cannot be saved without a section" do
    @reflection.section = nil
    assert_not @reflection.save, "Saved reflection without a section"
  end

  test "reflection cannot be saved without a goal" do
    @reflection.goal = nil
    assert_not @reflection.save, "Saved reflection without a goal"
  end
end
