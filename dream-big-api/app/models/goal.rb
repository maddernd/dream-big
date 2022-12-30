class Goal < ApplicationRecord
	belongs_to :section, required: true
	has_one :reflection
end
