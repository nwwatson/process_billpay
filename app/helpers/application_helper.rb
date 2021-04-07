module ApplicationHelper
  def controllers?(*controller_array)
    controller_array.each do |controller|
      return true if controller?(controller)
    end
    false
  end

  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def controller_root?(controller_root)
    params[:controller].starts_with?(controller_root)
  end

  def active_link?(controller, action = nil, css_class = 'link-secondary')
    #link-dark
    css_class if controller?(controller) && ((params[:action] == action) || action.nil?) ? true : false
  end
end
