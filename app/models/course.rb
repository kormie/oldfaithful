# == Schema Information
# Schema version: 20110124223158
#
# Table name: courses
#
#  id            :integer         not null, primary key
#  number        :integer
#  department_id :integer
#  description   :text
#  created_at    :datetime
#  updated_at    :datetime
#  professor     :string(255)
#  term          :string(255)
#  name          :string(255)
#

class Course < ActiveRecord::Base
  has_many :jots
  has_and_belongs_to_many :users
  belongs_to :department
  validates :number,
            :presence => true,
            :format => { :with => /^[1-9][0-9]{2}([-][0-9]{1})?$/i }
  validates_presence_of :professor, :message => "can't be blank"
  validates_presence_of :name, :message => "can't be blank"
  validates_presence_of :department_id, :on => :create, :message => "can't be blank"
  
  def published_jots
    jots.published
  end
  def drafted_jots
    jots.drafted
  end
  def num_published_jots
    published_jots.size
  end
  def num_drafted_jots
    drafted_jots.size
  end
  def num_jots
    jots.count
  end
  def title
    "#{department.name} #{number}"
  end
end
