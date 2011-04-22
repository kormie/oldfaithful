class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_by_resource
  before_filter :nav_spots

    def layout_by_resource
      if devise_controller?
        "intro"
      else
        "application"
      end
    end
    
    def after_sign_out_path_for(resource_or_scope)
      intro_index_path
    end
    def after_update_path_for(resource_or_scope)
      users_index_path
    end
    def find_current_user
      current_user
      @user = User.find(current_user.id)
      @courses = @user.courses.all
    end
    
    def nav_spots
      if @courses != nil
        @nav_spots = [{:image => "my_jots/slash", :path => courses_path}] 
        @nav_spots << {:image => "new_jot", :path => new_course_jot_path(@course ||= @user.courses.first)}
      else
        @nav_spots = [{:image => "my_jots", :path => jots_path }]
      end
      return @nav_spots
    end
    
    @welcome_message ||= "Welcome to Jot Locker"
    @day_number = DateTime.now.strftime('%d')
    @long_day = DateTime.now.strftime('%A, %m.%d')
    @today = DateTime.now
end
