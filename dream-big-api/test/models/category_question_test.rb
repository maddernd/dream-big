require "test_helper"

class CategoryQuestionTest < ActiveSupport::TestCase
  def setup
    # create category
    @category = Category.create(name: 'Category 1')

    # create category question
    @category_question = CategoryQuestion.create(
      question: 'question??',
      category: @category
    )
  end

  test "category belongs to association with category question is valid" do
    assert_equal @category, @category_question.category
  end

  test "modifying category and saving existing category question record works" do
    category = Category.create(name: 'Category 2')
    @category_question.category = category
    @category_question.save
    assert_equal category, @category_question.category
  end

  test "modifying question and saving existing category question record works" do
    @category_question.question = "What is the question?"
    @category_question.save
    assert_equal "What is the question?", @category_question.question
  end
end
