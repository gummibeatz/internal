module ApplicationHelper
  def pretty_date(date_time)
    date_time.strftime("%b %d, %Y")
  end
end
