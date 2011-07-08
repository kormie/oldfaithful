# == Schema Information
# Schema version: 20110124223158
#
# Table name: universities
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class University < ActiveRecord::Base
  has_many :users
  has_many :departments

  def all_courses
    all_courses = Array.new
    departments.each do |department|
      department.courses.each do |course|
        all_courses << course
      end
    end
    all_courses.flatten
  end

end
