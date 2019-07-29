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
    #binding.pry
    results_as_objects = []
    results_as_strings.each do |name|
      results_as_objects << self.all.find_by(name: name)
    end
    results_as_objects
  end
end
