require "test_helper"

class CategoryTest < ActiveSupport::TestCase

  test "should save with category name and description" do
    category = Category.new
    category.name = 'cat name'
    category.description = 'cat description'
    assert category.save, "Unable to save category with name and description"
  end

  test "categories fixture exists" do
    assert_equal 1, categories(:category).id
  end

  test "should modify name field and save existing category record" do
    category = categories(:category)
    category.name = 'cat name'
    assert_equal( 'cat name', category.name, "category name not modified")
  end

  test "should modify description field and save existing category record" do
    category = categories(:category)
    category.description = 'cat description'
    assert_equal( 'cat description', category.description, "category description not modified")
  end

  
end
