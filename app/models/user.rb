# == Schema Information
# Schema version: 20110124223158
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  first_name           :string(255)
#  last_name            :string(255)
#  major                :string(255)
#  city                 :string(255)
#  state                :string(255)
#  university_id        :integer
#  birthday             :date
#  name                 :string(255)
#  facebook_id          :string(255)
#

class User < ActiveRecord::Base
  has_many :authentications
  has_and_belongs_to_many :jots
  has_and_belongs_to_many :courses
  belongs_to :university
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :university_id, :course_ids, :birthday, :course, :facebook_id
  attr_accessor :university_name
  attr_accessor :published
  
   def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    fbid = access_token['uid']
    if user == User.find_by_email(data["email"])
      user
    else # Create an user with a stub password.
      User.create!(:email => data["email"], :name => data["name"], :password => Devise.friendly_token[0,20], :facebook_id => fbid) 
    end
  end
  
  def after_update_path
      users_path
  end
  def update_with_password(params={}) 
    if params[:password].blank? 
      params.delete(:password) 
      params.delete(:password_confirmation) if params[:password_confirmation].blank? 
    end 
    update_attributes(params) 
  end
  
  def self.order_recent
    order("updated_at DESC")
  end
  def self.uniq_recent
    order_recent.uniq
  end
  def self.recent_three
    order_recent.limit(3).uniq
  end
  def self.most_recent
    order_recent.limit(1)
  end
  
  def cap_email
    email.upcase
  end
  def first_name
    name.split(" ").first
  end
  def last_name
    name.split(" ").last
  end
  def university_name
    if university
      university.name
    else
      "University"
    end
  end
  def published_jots
    jots.uniq
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
  def course_count
    courses.count
  end
  def list_other_courses(current)
    courses.where("id != ?", current.id).order("title")
  end
  protected

end
