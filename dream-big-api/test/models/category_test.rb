require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = categories(:category_1)
  end

  test "should save with category name and description" do
    category = Category.new(name: 'cat name', description: 'cat description')
    assert category.save, "Unable to save category with name and description"
  end

  test "categories fixture exists" do
    assert_equal 'Employability', @category.name
  end

  test "should modify name field and save existing category record" do
    @category.name = 'cat name'
    assert_equal( 'cat name', @category.name, "category name not modified")
    assert @category.save, "Category was not saved after modifying name field"
  end

  test "should modify description field and save existing category record" do
    @category.description = 'cat description'
    assert_equal( 'cat description', @category.description, "category description not modified")
    assert @category.save, "Category was not saved after modifying description field"
  end
end
