# == Schema Information
#
# Table name: students
#
#  id         :integer          not null, primary key
#  name       :string
#  hometown   :string
#  birthday   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Student < ActiveRecord::Base
  has_many :classroom_students
  has_many :classrooms, through: :classroom_students

  def self.search(criteria)
    capitalized_criteria = criteria.capitalize
    names = self.all.collect {|student| student.name}
    results_as_strings = names.grep(/#{capitalized_criteria}\w+/)
    results_as_objects = self.all.select do |student|
      results_as_strings.each do |result|
        student.name == result
      end
    end
  end
end
