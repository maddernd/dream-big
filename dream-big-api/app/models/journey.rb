class Journey < ApplicationRecord
	belongs_to :student, required: true
	has_many :assessments
	has_many :planets
end
