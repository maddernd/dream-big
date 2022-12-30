class Answer < ApplicationRecord
	belongs_to :assessment, required: true
	belongs_to :category_question, required: true
end
