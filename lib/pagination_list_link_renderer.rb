class PaginationListLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer
  
  def container_attributes
      super.except(:previous_page, :next_page)
  end
  
  protected
  
  def pagination
    [:previous_page, :next_page]
  end
  
  def next_page
    previous_or_next_page(@collection.next_page, "<img src='/images/jots/arrow.png'>", 'hover_arrow', 'next_arrow')
  end
  def previous_page
    previous_or_next_page(@collection.previous_page, "<img src='/images/jots/arrow_back.png'>", 'hover_arrow', 'previous_arrow')
  end
  
  def previous_or_next_page(page, text, classname, idname)
          if page
            link(text, page, :class => classname, :id => idname)
          else
            tag(:span, text, :class => classname + ' disabled', :id => idname)
          end
        end
  def html_container(html)
          html
  end
end