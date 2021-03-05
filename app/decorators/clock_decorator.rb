class ClockDecorator < SimpleDelegator
  def display_timezone
    now.strftime('%F %T%:zUTC')
  end

  def select_color
    return "#FFFFFF" if code != 200
    weather = parsed_response
    case weather["main"]["temp"]
    when (..-20)
      "#08088A"
    when (-19..0)
      "#5858FA"
    when (1..10)
      "#81BEF7"
    when (11..20)
      "#FA5858"
    when (21..)
      "#B40404"
    else
      "#A4A4A4"
    end
  end
end
