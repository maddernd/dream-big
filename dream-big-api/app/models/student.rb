class Student < ApplicationRecord
  #assocations
  belongs_to :user, required: true
  has_one :student_journey
  has_one :avatar
end
