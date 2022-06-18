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

  def offense_count(num)
    num.positive? ? 'text-danger' : 'text-success'
  end

  def datetime_abb_month(datetime)
    datetime.strftime('%H:%M %B %d %Y')
  end
end
