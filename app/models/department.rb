# == Schema Information
# Schema version: 20110124223158
#
# Table name: departments
#
#  id            :integer         not null, primary key
#  university_id :integer
#  name          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Department < ActiveRecord::Base
  belongs_to :university
  has_many :courses
end
