# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://jotlocker.com"

SitemapGenerator::Sitemap.add_links do |sitemap|
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: sitemap.add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  # 
  # 
  # Examples:
  # 
    
    sitemap.add "/privacy"
    
    sitemap.add "/terms"
    
    sitemap.add courses_path, :priority => 0.7, :changefreq => 'daily'
    
    sitemap.add intro_index_path
    
    sitemap.add jots_path
    
    sitemap.add users_index_path
  
    
    Course.all.each do |course|
      sitemap.add course_path(course), :lastmod => course.updated_at
      jots = course.jots.each do |jot, course|
        sitemap.add course_jot_path(jot.course_id, jot), :lastmod => jot.updated_at
      end
    end

end