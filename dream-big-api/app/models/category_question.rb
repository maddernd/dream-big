class CategoryQuestion < ApplicationRecord
  #associations
  belongs_to :category, required: true
  has_one :answer
end
