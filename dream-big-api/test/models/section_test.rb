require "test_helper"

class SectionTest < ActiveSupport::TestCase

  test "categories fixture exists for foreign key" do
    assert_equal 1, categories(:category).id
    assert_equal categories(:category).id, sections(:section).category_id
  end

  test "planets fixture exists for foreign key" do
    assert_equal 1, planets(:planet).id
    assert_equal "test_planet", planets(:planet).name
    assert_equal planets(:planet).id, sections(:section).planet_id
  end

  test "should save when category_id(FK) exists in category table" do
    section = Section.new
    section.category_id = categories(:category).id
    assert section.save, "section not saved with category id"
  end

  test "should error when category_id(FK) does not exist in category table" do
    section = Section.new
    section.category_id = 123456789426
    assert_raises(ActiveRecord::InvalidForeignKey) do section.save
    end
  end

  test "should save when planet_id(FK) exists in planets table" do
    section = Section.new
    section.planet_id = planets(:planet).id
    assert section.save, "section not saved with planet id"
  end

  test "should error when planet_id(FK) does not exist in planets table" do
    section = Section.new
    section.planet_id = 123456789426
    assert_raises(ActiveRecord::InvalidForeignKey) do section.save
    end
  end

  test "all fields should save with both foreign key fields" do
    section = Section.new
    section.category_id = categories(:category).id
    section.planet_id = planets(:planet).id
    assert section.save, "section not saved"
  end

  test "should modify planet id and save existing section record " do
    section = sections(:section)
    section.planet_id = planets(:planet_2).id
    section.save
    assert_equal( planets(:planet_2).id, section.planet_id, "planet_id not modified")
    end  

    test "should modify category id and save existing section record " do
      section = sections(:section)
      section.category_id = categories(:category_2).id
      section.save
      assert_equal( categories(:category_2).id, section.category_id, "category_id not modified")
      end 

end
