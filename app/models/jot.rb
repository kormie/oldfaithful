# == Schema Information
# Schema version: 20110124223158
#
# Table name: jots
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  content    :text
#  visibility :boolean
#  created_at :datetime
#  updated_at :datetime
#  course_id  :integer
#

class Jot < ActiveRecord::Base
  belongs_to :course
  has_and_belongs_to_many :users
  validates_presence_of :course
  validates_presence_of :content
  validates_presence_of :title
  
  def self.drafted
    where("visibility = ?", true).uniq
  end
  def self.published
    where("visibility = ?", false).uniq
  end
  def most_recent_user
    users.most_recent
  end
  def uniq_users
    users.uniq
  end
  def num_users
    uniq_users.size
  end
  def uniq_recent_users
    users.uniq_recent
  end
end
