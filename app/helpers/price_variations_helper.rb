module PriceVariationsHelper
  def day_of_the_week_mapping(nb_day)
    case nb_day
    when 1
      'Monday'
    when 2
      'Tuesday'
    when 3
      'Wednesday'
    when 4
      'Thursday'
    when 5
      'Friday'
    when 6
      'Saturday'
    when 7
      'Sunday'
    else
      nil
    end
  end

  def day_of_the_week_options
    [{ id: 0, name: "" }, { id: 1, name: "Monday" },
     { id: 2, name: "Tuesday" }, { id: 3, name: "Wednesday" },
     { id: 4, name: "Thursday" }, { id: 5, name: "Friday" },
     { id: 6, name: "Saturday" }, { id: 7, name: "Sunday" }]
  end
end
