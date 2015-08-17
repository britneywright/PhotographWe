module ApplicationHelper

  def page_title(name = '')
    base_title = 'PhotographWe'
    if name.empty?
      base_title
    else
      name + " | " + base_title
    end
  end
end
