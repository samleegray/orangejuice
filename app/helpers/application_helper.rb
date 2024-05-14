module ApplicationHelper
  def page_title
    if @page_title
      @page_title + ' | Orangejuice'
    else
      'Orangejuice'
    end
  end

  def username(user)
    if user
      user.username
    else
      'Deleted Account'
    end
  end
end
