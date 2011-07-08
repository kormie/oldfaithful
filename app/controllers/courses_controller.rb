class CoursesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_current_user
  before_filter :breadcrumbs, :except => [:index]

  def one
    @departments = @user.university.departments
    render :layout => nil
  end

  def index
    @courses = @user.courses.order("name ASC")
    @column1 = @courses.limit(2)
    @column2 = @courses.limit(2).offset(2)
    @column3 = @courses.offset(4)
    @page_title = "#{current_user.first_name}'s Courses"
    @welcome_message = "#{@user.name}'s Courses"
    @breadcrumbs = [{:image => "jot_locker", :path => courses_path}]
    render :layout => "tall_pics"
  end

  def show
    @course = Course.find(params[:id])
    @courses = @user.courses.where("id != ?", params[:id]).order("name")
    @jots = @course.jots.order("updated_at DESC")
    @page_title = "#{@course.name}"
    @welcome_message = @page_title

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @course }
    end
  end

  def new
    @course = Course.new
    @page_title = "New Course"
    @welcome_message = @page_title

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @course }
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to(edit_user_registration_path, :anchor => "Courses", :notice => 'Course was successfully created.') }
        format.xml  { render :xml => @course, :status => :created, :location => @course }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to(@course, :notice => 'Course was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to(courses_url) }
      format.xml  { head :ok }
    end
  end
  def course_column
    @course = Course.all
  end
  
  private
  
  def breadcrumbs
    @breadcrumbs =[{:image => "jot_locker/arrow", :path => courses_path}]
  end
  

  
  
  
  
  
  
end
