module ApplicationHelper
  def bootstrap_flash_types(type)
    case type
    when :notice
      'secondary'
    when :alert
      'danger'
    else
      'secondary'
    end
  end

  def submit_text(action)
    case action
    when 'new', 'create'
      'Create'
    when 'edit', 'update'
      'Update'
    else
      'Submit'
    end
  end

  def pages_count
    return (@record_count / @limit.to_f).ceil if @record_count > @limit

    1
  end

  def paginate_pages
    less = [1, @pages - 2].max
    max = [pages_count - 2, @pages + 2].min

    (less..max).to_a
  end

  def show_left_dots?
    return false if (@pages - 2) < 2

    true
  end

  def show_right_dots?
    return false if (@pages + 2) > pages_count - 3

    true
  end
end
