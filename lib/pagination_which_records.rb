class PaginationWhichRecords < WillPaginate::ViewHelpers::LinkRenderer

  def container_attributes
      super.except(:first_record)
  end
  
  protected
  
  def pagination
    [:first_record]
  end
  
  def first_record
    tag(:p, "%d - %d of %d Jotted" % [@collection.offset + 1, @collection.offset + @collection.length, @collection.total_entries] )
  end
  
  def html_container(html)
          html
  end
  
end