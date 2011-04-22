class JotsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_current_user
  before_filter :course, :except => [:index]
  before_filter :courses
  respond_to :html, :json, :xml
  before_filter :breadcrumbs, :except => [:index]

  def index
    @page_title = "#{current_user.first_name}'s Jots"
    @welcome_message = @page_title
    @jots = @user.jots.order("updated_at DESC").uniq
    @breadcrumbs = [{:image => "jot_locker/arrow", :path => courses_path}]
    @breadcrumbs << {:image => "jots", :path => jots_path}
    respond_to do |format|
      format.html
      format.atom { render :layout => false } #index.rss.builder
    end
  end
  
  def show
    @page_title = "#{@course.title} Jot"
    @welcome_message = @page_title
    @jot = Jot.find(params[:id])
    respond_with @jot
  end

  def new
    @page_title = "New #{@course.title} Jot"
    @welcome_message = "New #{@course.title} Jot"
    @jot = @course.jots.new
    respond_with [@course, @jot]
  end

  def edit
    @jot = Jot.find(params[:id])
    @page_title = "Editing \"#{@jot.title}\""
    @welcome_message = @page_title
    respond_with @jot
  end

  def create
    @jot = @course.jots.new(params[:jot])
    
    respond_to do |format|
      if @jot.save && @jot.users << current_user
        format.html { redirect_to([@course, @jot], :notice => 'New Jot Created Successfully') }
      else
        format.html { render :action => 'new' }
      end
    end
  end

  def update
    @jot = Jot.find(params[:id])

    respond_to do |format|
      if @jot.update_attributes(params[:jot]) && @jot.users << current_user
        format.html { redirect_to([@course, @jot], :notice => 'Jot was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @jot.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @jot = @course.jots.find(params[:id])
    @jot.destroy

    respond_to do |format|
      format.html { redirect_to(jots_url) }
      format.xml  { head :ok }
    end
  end
  
  private


  def course
      @course ||= Course.find(params[:course_id])
  end
  def courses
      @courses = @user.courses.where("id != ?", params[:course_id]).order("name")
  end
  def breadcrumbs
    @breadcrumbs = [{:image => "my_jots/arrow", :path => jots_path}]
  end
  
end
