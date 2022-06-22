# frozen_string_literal: true

module ApplicationHelper
  def flash_class(type)
    case type
    when 'error', 'alert'
      'alert-secondary'
    when 'notice', 'success'
      'alert-light'
    else
      type.to_s
    end
  end

  def passed_theme(bull)
    bull ? 'text-success' : 'text-danger'
  end
end
