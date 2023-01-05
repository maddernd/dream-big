class Reflection < ApplicationRecord
	belongs_to :section, required: true
	belongs_to :goal, required: true

end
