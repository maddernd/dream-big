require "test_helper"

class SectionTest < ActiveSupport::TestCase
  test "should save when both category and planet associations exist" do
    section = Section.new
    section.category = categories(:category_1)
    section.planet = planets(:planet_1)
    assert section.save, "section not saved with category and planet associations"
  end

  test "should error when category association does not exist" do
    section = Section.new
    section.planet = planets(:planet_1)
    assert_not section.save, "Saved section without a category"
  end

  test "should error when planet association does not exist" do
    section = Section.new
    section.category = categories(:category_1)
    assert_not section.save, "Saved section without a planet"
  end

  test "should modify planet association and save existing section record" do
    section = sections(:section_1)
    section.planet = planets(:planet_2)
    section.save
    assert_equal(planets(:planet_2), section.planet, "planet association not modified")
  end

  test "should modify category association and save existing section record" do
    section = sections(:section_1)
    section.category = categories(:category_2)
    section.save
    assert_equal(categories(:category_2), section.category, "category association not modified")
  end

  test "all fields should save when modifying both foreign key associations" do
    section = sections(:section_1)
    section.planet = planets(:planet_2)
    section.category = categories(:category_2)
    section.save
    assert_equal(planets(:planet_2), section.planet, "planet association not modified")
    assert_equal(categories(:category_2), section.category, "category association not modified")
  end
end
