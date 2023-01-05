class Section < ApplicationRecord
     #assocations
     belongs_to :planet, required: true
     belongs_to :category, required: true
  

end
