class Planet < ApplicationRecord
	belongs_to :journey, required: true
end
