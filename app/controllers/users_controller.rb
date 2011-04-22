class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_current_user
  def index
    @page_title = "#{current_user.first_name}'s Locker"
    @welcome_message = "#{@user.name}'s Locker"
    render :layout => "tall_pics"
  end
  
  def edit
    @page_title = "Editing #{current_user.first_name}'s Locker"
    @welcome_message = "Edit My Locker"
  end
  
  private
  
  def university_name
    if university
      university.name
    else
      "University"
    end
  end

end