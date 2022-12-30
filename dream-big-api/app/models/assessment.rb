class Assessment < ApplicationRecord
	belongs_to :journey, required: true
	belongs_to :category, required: true

	has_many :answers
	
end
