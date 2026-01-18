class CourseClass < ApplicationRecord
  belongs_to :professor
  belongs_to :product
end
