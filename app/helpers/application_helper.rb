module ApplicationHelper
  
  def logo_link
    link_to "Logo", root_path , :id => "large_header_logo"
  end
  
  def feedback_email
    link_to "Feedback", "mailto:feedback@jotlocker.com"
  end
  
  def contact_email
    link_to "Contact Us", "mailto:contact@jotlocker.com"
  end
  
  def log_out_link
    link_to "Log Out", destroy_user_session_path
  end
  
  def preferences_link
    link_to "Preferences", edit_user_registration_path, :class => "yellow"
  end
  
  def date_at_time var
    var.strftime('%B %e, %Y @ %I:%M %p')
  end
  
  def current_offset jot
    @collection = jot.course.jots.order('updated_at DESC')
    @position = @collection.index(jot) + 1
    return @position
  end
  
  def shorten_jot jot
    return jot.content.truncate(90)
  end
  
  def course_name course
    return course.department.name + " " + course.number.to_s
  end
  
  def jot_title (jot)
    if jot.visibility == true
      jot.title = ("#{h(jot.title)}<span class='meta asterisk'> *</span>").html_safe
    end
    return jot.title
  end
  
  def navigation_links(links, *args)
    
    @section = "discuss"
    @color   = "white"
    @top     = false

    link_list = []

    navigation_variable_assigner(args)

    if @top
      link_list.push(image_tag_location_on_disc(@section))
    end

    build_link_list(links, link_list)

    link_list.join.html_safe
  end

  def image_tag_location_on_disc(subfolder)
    image_tag("color_navtabs/#{@section}_text/#{subfolder}/#{@color}.png")
  end

  def navigation_variable_assigner(options_list)
    if options_list[0].is_a?(Hash)
      options_list[0].each do |value|
        instance_variable_set("@#{value[0]}", value[1])
      end
    else
      @section = options_list[0] || "discuss"
      @color   = options_list[1] || "white"
      @top     = options_list[2] || false
    end
  end

  def build_link_list(links, link_list)
    links.each do |link|
      disc_location = image_tag_location_on_disc(link[:disc])
      link = link_to_unless_current(disc_location, link[:web])
      link_list.push(link)
    end
  end
  
  def hide(element, show=false)
    element=nil
  end
  
  def year
    DateTime.now.strftime('%Y')
  end
  
  def avatar_url(user)
    default_url = "#{root_url}images/locker/snapshot/head.gif"
    facebook_url = session[:fbpic]
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=80&d=#{CGI.escape(default_url)}"
  end
  
  def pub_count(course)
    "Published (#{course.num_published_jots})"
  end
  
  def draft_count(course)
    "Drafted (#{course.num_drafted_jots})"
  end
  
  def new_course_jot_links(course)
    jot = link_to "New", new_course_jot_path(course)
  end
  
  def view_course_jot_links(course)
    jot = link_to "View all", course
  end
  
  def course_jot_links(course)
    jot = link_to "New", new_course_jot_path(course)
    jot += " / "
    jot += link_to "View", course
  end

end