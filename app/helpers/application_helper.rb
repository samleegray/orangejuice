module ApplicationHelper
  def page_title
    if @page_title
      @page_title + " | Orangejuice"
    else
      "Orangejuice"
    end
  end
end
