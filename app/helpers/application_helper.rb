module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :notice
      'alert alert-info alert-dismissible'
    when :success
      'alert alert-success alert-dismissible'
    when :error
      'alert alert-danger alert-dismissible'
    when :alert
      'alert alert-danger alert-dismissible'
    else
      'alert alert-info alert-dismissible'
    end
  end
end
